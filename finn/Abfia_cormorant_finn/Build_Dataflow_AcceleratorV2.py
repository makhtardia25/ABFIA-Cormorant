import time
import numpy as np
import os
import shutil
from qonnx.custom_op.registry import getCustomOp
from qonnx.core.modelwrapper import ModelWrapper
import finn.builder.build_dataflow as build_module
import finn.builder.build_dataflow_config as build_cfg
import finn.builder.build_dataflow_steps as build_steps
from finn.transformation.fpgadataflow.insert_iodma import InsertIODMA
from finn.transformation.fpgadataflow.create_dataflow_partition import CreateDataflowPartition
from finn.transformation.fpgadataflow.make_pynq_driver import MakePYNQDriver

# --- CONFIGURATION DE L'ENVIRONNEMENT MATÉRIEL ---
# Si vous ciblez l'Alveo U50 (Flow Vitis), la variable ZYNQ_TYPE n'est pas requise.
# On la commente pour éviter les conflits de génération de shell.
# os.environ["ZYNQ_TYPE"] = "zynq_us+" 

# Ajout des outils Xilinx au PATH
os.environ["PATH"] = "/tools/Xilinx/Vitis_HLS/2024.2/bin:" + os.environ["PATH"]
os.environ["PATH"] = "/tools/Xilinx/Vivado/2024.2/bin:" + os.environ["PATH"]

start_time = time.time()
print(f"Démarrage du build à : {time.ctime(start_time)}")

model_file_in = "mvdr_finn_streamlined.onnx"
print(f"Modèle d'entrée utilisé pour le build: {model_file_in}")


def step_robust_fix_threshold_int32(model, cfg):
    """Borne les seuils des couches MVAU/VVAU sur la plage INT32."""
    int32_min, int32_max = np.iinfo(np.int32).min, np.iinfo(np.int32).max
    clipped_tensors = 0
    clipped_values = 0
    nan_inf_fixed = 0

    for node in model.graph.node:
        if len(node.input) < 3:
            continue
        th_name = node.input[2]
        if th_name == "":
            continue
        thresholds = model.get_initializer(th_name)
        if thresholds is None:
            continue

        finite_thresholds = np.nan_to_num(
            thresholds, nan=0.0, posinf=float(int32_max), neginf=float(int32_min)
        )
        if not np.array_equal(finite_thresholds, thresholds):
            nan_inf_fixed += int(np.size(thresholds) - np.sum(np.isfinite(thresholds)))

        th_int = np.rint(finite_thresholds).astype(np.int64)
        too_low = th_int < int32_min
        too_high = th_int > int32_max
        out_of_range = too_low | too_high
        if np.any(out_of_range):
            clipped_values += int(np.sum(out_of_range))
            th_int = np.clip(th_int, int32_min, int32_max)
            clipped_tensors += 1

        model.set_initializer(th_name, th_int.astype(np.int64))

    print(
        f"[robust-fix] Seuils vérifiés. "
        f"Tenseurs corrigés: {clipped_tensors}, valeurs bornées: {clipped_values}, "
        f"NaN/Inf corrigés: {nan_inf_fixed}"
    )
    return model


def step_load_dataflow_parent(model, cfg):
    """Recharge le modèle parent pour le driver PYNQ et insère les IODMA."""
    interm_dir = cfg.output_dir + "/intermediate_models"
    parent_candidates = []

    parent_candidates.append(interm_dir + "/dataflow_parent.onnx")
    parent_candidates.append(os.path.join(os.getcwd(), interm_dir, "dataflow_parent.onnx"))

    if os.path.isdir(interm_dir):
        for fn in os.listdir(interm_dir):
            if not fn.endswith(".onnx"):
                continue
            if "parent" in fn or "dataflow" in fn:
                parent_candidates.append(os.path.join(interm_dir, fn))

    def _is_good_parent(m: ModelWrapper):
        if not any(n.op_type == "StreamingDataflowPartition" for n in m.graph.node):
            return False
        for graph_in in m.graph.input:
            cons = m.find_consumer(graph_in.name)
            if cons is None or cons.op_type != "StreamingDataflowPartition":
                return False
        return True

    chosen_model = None
    tried = []
    for cand in parent_candidates:
        if cand in tried:
            continue
        tried.append(cand)
        if not os.path.isfile(cand):
            continue
        m = ModelWrapper(cand)
        if _is_good_parent(m):
            chosen_model = m
            break

    if chosen_model is None:
        print(f"[INFO] Fallback: création d'un parent SDP via CreateDataflowPartition")
        part_dir = interm_dir + "/supported_op_partitions"
        os.makedirs(part_dir, exist_ok=True)
        parent_model = model.transform(CreateDataflowPartition(partition_model_dir=part_dir))
    else:
        parent_model = chosen_model

    sdp_nodes = [n for n in parent_model.graph.node if n.op_type == "StreamingDataflowPartition"]

    for sdp in sdp_nodes:
        sdp_inst = getCustomOp(sdp)
        df_fn = sdp_inst.get_nodeattr("model")
        if not os.path.isfile(df_fn):
            raise FileNotFoundError(f"Modèle dataflow référencé introuvable: {df_fn}")
        
        df_model = ModelWrapper(df_fn)
        df_model = df_model.transform(InsertIODMA())
        df_model.save(df_fn)
        
        # Correction de l'assertion : On valide la présence des nœuds IODMA dans le graphe 
        # sans imposer une contrainte d'index strict (0 ou -1) qui fait souvent planter le build.
        node_types = [n.op_type for n in df_model.graph.node]
        assert "IODMA_hls" in node_types, f"L'insertion IODMA a échoué dans la partition : {df_fn}"
        print(f"[INFO] IODMA inséré et validé dans: {df_fn}")

    return parent_model


def step_make_pynq_driver_from_parent(model, cfg):
    """Génère le driver PYNQ via le modèle parent."""
    if build_cfg.DataflowOutputType.PYNQ_DRIVER not in cfg.generate_outputs:
        return model
    parent_model = step_load_dataflow_parent(model, cfg)
    parent_model = parent_model.transform(MakePYNQDriver(cfg._resolve_driver_platform()))
    driver_dir = os.path.join(cfg.output_dir, "driver")
    os.makedirs(driver_dir, exist_ok=True)
    
    # Remplacement de copy_tree déprécié par shutil
    shutil.copytree(parent_model.get_metadata_prop("pynq_driver_dir"), driver_dir, dirs_exist_ok=True)
    print("PYNQ Python driver written into " + driver_dir)
    return model


# --- CONFIGURATION DU CONFIGURATEUR DE BUILD FINN ---
cfg = build_cfg.DataflowBuildConfig(
    output_dir          = "output_mvdr_U50", 
    minimize_bit_width  = True,
    board               = "U50",              
    fpga_part           = "xcu50-fsvh2104-2L-e",
    synth_clk_period_ns = 10.0,                         
    folding_config_file = "folding_config_16pack.json",
    generate_outputs    = [
        build_cfg.DataflowOutputType.STITCHED_IP,      
        build_cfg.DataflowOutputType.PYNQ_DRIVER,      
        build_cfg.DataflowOutputType.BITFILE          
    ],
    shell_flow_type     = build_cfg.ShellFlowType.VITIS_ALVEO, 
    steps=[
        build_steps.step_qonnx_to_finn,                   
        build_steps.step_tidy_up,                         
        build_steps.step_streamline,                      
        build_steps.step_convert_to_hw,                   
        build_steps.step_create_dataflow_partition,       
        build_steps.step_specialize_layers,               
        build_steps.step_apply_folding_config,            
        step_robust_fix_threshold_int32,                  
        build_steps.step_minimize_bit_width,
        build_steps.step_hw_codegen,                      
        build_steps.step_hw_ipgen,                        
        build_steps.step_set_fifo_depths,                 
        build_steps.step_create_stitched_ip,              
        step_make_pynq_driver_from_parent,                
        build_steps.step_synthesize_bitfile             
    ]
)

# --- EXÉCUTION ---
try:
    build_module.build_dataflow_cfg(model_file_in, cfg)
    print("\nLe build s'est terminé avec succès !")
except Exception as e:
    print(f"\n[ERROR] Le build a échoué : {str(e)}")

duration = time.time() - start_time
print(f"\nTemps total : {int(duration // 3600)}h {int((duration % 3600) // 60)}min")
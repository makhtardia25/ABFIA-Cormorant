import time
import numpy as np
from qonnx.custom_op.registry import getCustomOp
from qonnx.core.modelwrapper import ModelWrapper
import finn.builder.build_dataflow as build_module
import finn.builder.build_dataflow_config as build_cfg
import finn.builder.build_dataflow_steps as build_steps
import os
from distutils.dir_util import copy_tree
from finn.transformation.fpgadataflow.insert_iodma import InsertIODMA
from finn.transformation.fpgadataflow.create_dataflow_partition import CreateDataflowPartition
from finn.transformation.fpgadataflow.make_pynq_driver import MakePYNQDriver
# --- DÉBUT DU BUILD ---
os.environ["ZYNQ_TYPE"] = "zynq_us+"  # au cas ou finn bug pour la zcu111 > can't read "ZYNQ_TYPE": no such variable
# 2. On s'assure aussi que Vivado et Vitis HLS sont bien dans le PATH (comme vu à l'étape précédente)
# Remplace 202X.X par ta version exacte (ex: 2024.2) si ce n'est pas déjà fait
os.environ["PATH"] = "/tools/Xilinx/Vitis_HLS/2024.2/bin:" + os.environ["PATH"]
os.environ["PATH"] = "/tools/Xilinx/Vivado/2024.2/bin:" + os.environ["PATH"]

start_time = time.time()
print(f"Démarrage du build à : {time.ctime(start_time)}")

# Entrée du build : modèle déjà exporté/streamliné en 16-bit
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

        # Nettoyage NaN/Inf avant conversion entière.
        finite_thresholds = np.nan_to_num(
            thresholds, nan=0.0, posinf=float(int32_max), neginf=float(int32_min)
        )
        if not np.array_equal(finite_thresholds, thresholds):
            nan_inf_fixed += int(np.size(thresholds) - np.sum(np.isfinite(thresholds)))

        # Le générateur HLS attend des seuils entiers représentables par accDataType.
        th_int = np.rint(finite_thresholds).astype(np.int64)
        too_low = th_int < int32_min
        too_high = th_int > int32_max
        out_of_range = too_low | too_high
        if np.any(out_of_range):
            clipped_values += int(np.sum(out_of_range))
            th_int = np.clip(th_int, int32_min, int32_max)
            clipped_tensors += 1

        # Garder un type entier exact pour eviter le re-arrondi float32 pres de 2^31.
        model.set_initializer(th_name, th_int.astype(np.int64))

    print(
        f"[robust-fix] Seuils vérifiés. "
        f"Tenseurs corrigés: {clipped_tensors}, valeurs bornées: {clipped_values}, "
        f"NaN/Inf corrigés: {nan_inf_fixed}"
    )
    return model


def step_load_dataflow_parent(model, cfg):
    """Recharge le modèle parent (avec StreamingDataflowPartition) pour le driver PYNQ."""
    interm_dir = cfg.output_dir + "/intermediate_models"
    parent_candidates = []

    # Preferred location
    parent_candidates.append(interm_dir + "/dataflow_parent.onnx")
    parent_candidates.append(os.path.join(os.getcwd(), interm_dir, "dataflow_parent.onnx"))

    # Fallbacks: scan intermediate_models for any likely parent graphs
    if os.path.isdir(interm_dir):
        for fn in os.listdir(interm_dir):
            if not fn.endswith(".onnx"):
                continue
            if "parent" in fn or "dataflow" in fn:
                parent_candidates.append(os.path.join(interm_dir, fn))

    def _is_good_parent(m: ModelWrapper):
        # must have at least one SDP
        if not any(n.op_type == "StreamingDataflowPartition" for n in m.graph.node):
            return False
        # each graph input should feed into an SDP
        for graph_in in m.graph.input:
            cons = m.find_consumer(graph_in.name)
            if cons is None or cons.op_type != "StreamingDataflowPartition":
                return False
        return True

    chosen = None
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
            chosen = cand
            chosen_model = m
            break

    if chosen_model is None:
        print(
            f"[WARN] Aucun modèle parent valide trouvé pour le driver PYNQ. "
            f"Candidats testés: {tried}"
        )
        # print diagnostic for the originally produced parent if it exists
        if os.path.isfile(interm_dir + "/dataflow_parent.onnx"):
            m0 = ModelWrapper(interm_dir + "/dataflow_parent.onnx")
            for gi in m0.graph.input:
                cons = m0.find_consumer(gi.name)
                print(f"[DIAG] input '{gi.name}' consumer: {None if cons is None else cons.op_type}")

        # Fallback: (re)créer un parent avec StreamingDataflowPartition autour du modèle courant.
        # Cela permet à MakePYNQDriver de retrouver un SDP au niveau top.
        part_dir = interm_dir + "/supported_op_partitions"
        os.makedirs(part_dir, exist_ok=True)
        print(f"[INFO] Fallback: création d'un parent SDP via CreateDataflowPartition ({part_dir})")
        parent_model = model.transform(CreateDataflowPartition(partition_model_dir=part_dir))
        chosen = "(fallback CreateDataflowPartition)"
        chosen_model = parent_model

    print(f"[INFO] Modèle parent sélectionné pour driver: {chosen}")
    parent_model = chosen_model
    sdp_nodes = [n for n in parent_model.graph.node if n.op_type == "StreamingDataflowPartition"]
    print(f"[INFO] StreamingDataflowPartition détecté(s): {len(sdp_nodes)}")

    # Pré-requis MakePYNQDriver:
    # le sous-modèle référencé par le StreamingDataflowPartition d'entrée doit
    # commencer par IODMA_hls (et celui de sortie doit finir par IODMA_hls).
    for sdp in sdp_nodes:
        sdp_inst = getCustomOp(sdp)
        df_fn = sdp_inst.get_nodeattr("model")
        if not os.path.isfile(df_fn):
            raise FileNotFoundError(f"Modèle dataflow référencé introuvable: {df_fn}")
        df_model = ModelWrapper(df_fn)
        df_model = df_model.transform(InsertIODMA())
        df_model.save(df_fn)
        assert df_model.graph.node[0].op_type == "IODMA_hls", "First partition must hold input IODMA"
        assert df_model.graph.node[-1].op_type == "IODMA_hls", "Partition must hold output IODMA"
        print(f"[INFO] IODMA vérifié/inséré dans: {df_fn}")

    return parent_model


def step_make_pynq_driver_from_parent(model, cfg):
    """Génère le driver PYNQ via le modèle parent, sans changer le modèle courant.

    Important: le modèle "courant" (dataflow / stitched) est requis pour la bitgen,
    tandis que MakePYNQDriver attend un graphe top-level avec StreamingDataflowPartition.
    """
    if build_cfg.DataflowOutputType.PYNQ_DRIVER not in cfg.generate_outputs:
        return model
    parent_model = step_load_dataflow_parent(model, cfg)
    parent_model = parent_model.transform(MakePYNQDriver(cfg._resolve_driver_platform()))
    driver_dir = cfg.output_dir + "/driver"
    os.makedirs(driver_dir, exist_ok=True)
    copy_tree(parent_model.get_metadata_prop("pynq_driver_dir"), driver_dir)
    print("PYNQ Python driver written into " + driver_dir)
    return model

# Configuration du flux de données
"""
cfg = build_cfg.DataflowBuildConfig(
    output_dir          = "output_mvdr_U50", 
    #output_dir          = "output_mvdr_KR260",
    minimize_bit_width = True,
    board               = "U50",              # <--- 
    #board               = "KV260_SOM",          # <---
    fpga_part           = "xcu50-fsvh2104-2L-e",  # pour le Alveo U50
    #fpga_part           = "xczu28dr-ffvg1517-2-e", # La part exacte de la ZCU111
    synth_clk_period_ns = 10.0,
    folding_config_file = "folding_config_16pack.json",
    generate_outputs    = [build_cfg.DataflowOutputType.BITFILE, build_cfg.DataflowOutputType.PYNQ_DRIVER],
    shell_flow_type     = build_cfg.ShellFlowType.VIVADO_ZYNQ, 
    steps=[

        build_steps.step_qonnx_to_finn,                 # [1/15]  
        build_steps.step_tidy_up,                       # [2/15] 
        build_steps.step_streamline,                    # [3/15] 
        build_steps.step_convert_to_hw,                 # [4/15] 
        build_steps.step_create_dataflow_partition,     # [5/15] 
        build_steps.step_specialize_layers,             # [6/15] 
        build_steps.step_apply_folding_config,          # [7/15] 
        step_robust_fix_threshold_int32,                # [8/15] 
        build_steps.step_minimize_bit_width,
        build_steps.step_hw_codegen,                    # [1015] 
        build_steps.step_hw_ipgen,                      # [11/15] 
        build_steps.step_set_fifo_depths,               # [12/15] 
        build_steps.step_create_stitched_ip,            # [13/15] 
        step_make_pynq_driver_from_parent,              # [14/15]         
        build_steps.step_synthesize_bitfile             # [15/15] 
    ]
)
"""
cfg = build_cfg.DataflowBuildConfig(
    output_dir          = "output_mvdr_U50", 
    minimize_bit_width  = True,
    board               = "U50",              
    fpga_part           = "xcu50-fsvh2104-2L-e",
    synth_clk_period_ns = 10.0,                         # 100 MHz (Idéal pour valider la simulation)
    folding_config_file = "folding_config_16pack.json",

    # --- CONFIGURATION SIMULATION PYVERILATOR ---
    verify_steps = [
        build_cfg.VerificationStepType.STITCHED_IP_RTLSIM
    ],
    
    # Nouveaux noms de fichiers dans le sous-dossier Data local
    verify_input_npy           = "/home/e2405238/finn/Abfia_cormorant/Data/sim_x.npy",
    verify_expected_output_npy = "/home/e2405238/finn/Abfia_cormorant/Data/sim_y.npy",
    
    # --- SORTIES POUR LE FLUX VITIS ---
    generate_outputs = [
        build_cfg.DataflowOutputType.STITCHED_IP,      # Génère le dossier stitched_ip requis
        build_cfg.DataflowOutputType.PYNQ_DRIVER       # Génère le driver adapté à l'hôte x86 / XRT
    ],
    
    # --- FLUX MATÉRIEL CIBLE ---
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
        build_steps.step_synthesize_bitfile             # Génère le fichier objet Vitis (.xo)
    ]
)
try:
    build_module.build_dataflow_cfg(model_file_in, cfg)
    print("\n Le build s'est terminé !")
except Exception as e:
    print(f"\n[ERROR] Le build a échoué : {str(e)}")

duration = time.time() - start_time
print(f"\nTemps total : {int(duration // 3600)}h {int((duration % 3600) // 60)}min")

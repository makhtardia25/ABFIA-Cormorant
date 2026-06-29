import onnx
from qonnx.core.modelwrapper import ModelWrapper
from qonnx.transformation.infer_shapes import InferShapes
from qonnx.transformation.fold_constants import FoldConstants
from qonnx.transformation.infer_datatypes import InferDataTypes
from qonnx.transformation.general import GiveReadableTensorNames, GiveUniqueNodeNames, GiveUniqueParameterTensors

import finn.transformation.qonnx.quant_act_to_multithreshold as qonnx_to_multi
import finn.transformation.qonnx.convert_qonnx_to_finn as qonnx_to_finn

# 1. Charger le modèle source (celui de Brevitas)
onnx_file = "mvdr_opset9W16A8.onnx"
model = ModelWrapper(onnx_file)

# 2. Nettoyage de base pour préparer le graphe
print("Nettoyage et renommage des tenseurs...")
model = model.transform(InferShapes())
model = model.transform(FoldConstants())
model = model.transform(GiveUniqueNodeNames())
model = model.transform(GiveUniqueParameterTensors())
model = model.transform(GiveReadableTensorNames())

# 3. Conversion des nœuds Quant (Brevitas) en MultiThreshold (FINN)
# W16A8: activations en 8-bit pour garder le MultiThreshold synthétisable.
# ou W16A16: activations en 16-bit pour une meilleure précision (mais plus lourd à synthétiser).
print("Conversion des Quants en MultiThreshold (<=8-bit)...")
filter_fn = qonnx_to_multi.default_filter_function_generator(max_multithreshold_bit_width=8)
model = model.transform(qonnx_to_multi.ConvertQuantActToMultiThreshold(filter_function=filter_fn))

# Propagation des types après conversion
model = model.transform(InferDataTypes())

# 4. Conversion finale vers le dialecte matériel de FINN
print("Conversion vers le dialecte FINN...")
model = model.transform(qonnx_to_finn.ConvertQONNXtoFINN())

# 5. Sauvegarde du modèle prêt pour le Streamlining et le Build
output_file = "mvdr_finn-onnx_ready_to_streamline.onnx"
model.save(output_file)

print("-" * 30)
print(f"Modèle {output_file} généré !")
print("Prochaine étape : Lancer ton script de Streamlining.")
print("-" * 30)

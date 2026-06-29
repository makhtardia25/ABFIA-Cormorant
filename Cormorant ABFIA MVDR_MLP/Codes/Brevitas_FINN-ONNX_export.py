from finn.util.test import get_test_model_trained
from qonnx.core.modelwrapper import ModelWrapper

# Charger le modèle dans l'environnement FINN
onnx_file = "../models_FFNN_Quantifie/mvdr_16bit_finn.onnx"
model = ModelWrapper(onnx_file)

# Le Nettoyage (Cleanup)
from qonnx.transformation.general import GiveReadableTensorNames, GiveUniqueNodeNames, GiveUniqueParameterTensors
from qonnx.transformation.infer_shapes import InferShapes
from qonnx.transformation.fold_constants import FoldConstants

# On enchaîne les transformations
model = model.transform(InferShapes())
model = model.transform(FoldConstants())
model = model.transform(GiveUniqueNodeNames())
model = model.transform(GiveUniqueParameterTensors())
model = model.transform(GiveReadableTensorNames())

# Conversion vers le dialecte FINN (MoveToHWBright)
from finn.transformation.qonnx.convert_qonnx_to_finn import ConvertQONNXtoFINN

model = model.transform(ConvertQONNXtoFINN())
model.save("mvdr_finn_ready.onnx")
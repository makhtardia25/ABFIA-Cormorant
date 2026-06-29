import numpy as np
from qonnx.core.modelwrapper import ModelWrapper
from qonnx.transformation.general import GiveUniqueNodeNames
from qonnx.transformation.infer_shapes import InferShapes
from qonnx.transformation.infer_datatypes import InferDataTypes
from finn.transformation.streamline import Streamline

# 1. Charger le modèle
model = ModelWrapper("mvdr_finn-onnx_ready_to_streamline.onnx")

# 2. Donner des noms uniques pour faciliter la lecture
model = model.transform(GiveUniqueNodeNames())

# 3. CORRECTIF : Remplacer les zéros par une valeur infime
# Ce correctif est excellent car il évite les divisions par zéro 
# lors des simplifications mathématiques (absorb_sign, etc.)
print("Correction des initialiseurs nuls...")
for init in model.graph.initializer:
    name = init.name
    val = model.get_initializer(name)
    if val is not None:
        if (val == 0).any():
            new_val = val.copy()
            new_val[new_val == 0] = 1e-9 
            model.set_initializer(name, new_val)

# 4. Lancer le Streamlining (Nettoyage lourd)
# Cette étape va fusionner les BatchNorm et simplifier les constantes
print("Exécution du Streamlining...")
model = model.transform(Streamline())

# --- AJOUT CRUCIAL ICI ---
# Après le Streamline, les types peuvent être "flous". 
# On force FINN à recalculer les formes et les types de données 
# pour confirmer que nos patchs UINT16 sont toujours bien là.
print("Ré-inférence des formes et types...")
model = model.transform(InferShapes())
model = model.transform(InferDataTypes())
# -------------------------

# 5. Sauvegarder le résultat
model.save("mvdr_finn_streamlined.onnx")
print(" Modèle Streamlined sauvegardé avec succès.")

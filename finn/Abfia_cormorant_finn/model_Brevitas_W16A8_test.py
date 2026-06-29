import numpy as np
from matplotlib import pyplot as plt
import os
import torch
import torch.nn as nn
import torch.nn.functional as F

# =============================================================================
# --- 1. CHARGEMENT DU MODELE VIA PYTORCH / BREVITAS ---
# =============================================================================

class MVDR_FFNN(nn.Module):
    def __init__(self):
        super(MVDR_FFNN, self).__init__()
        self.layer1 = nn.Linear(3, 512)
        self.layer2 = nn.Linear(512, 1024)
        self.layer3 = nn.Linear(1024, 2048)
        self.layer4 = nn.Linear(2048, 1024)
        self.layer5 = nn.Linear(1024, 32)
        
    def forward(self, x):
        x = F.leaky_relu(self.layer1(x), 0.1)
        x = F.leaky_relu(self.layer2(x), 0.1)
        x = F.leaky_relu(self.layer3(x), 0.1)
        x = F.leaky_relu(self.layer4(x), 0.1)
        x = self.layer5(x)        
        return x

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

checkpoint_name = "mvdr_opset9W16A16.pth" 

if not os.path.exists(checkpoint_name):
    print("Tentative de lecture du graphe ONNX via la suite d'outils FINN...")
    from qonnx.core.modelwrapper import ModelWrapper
    from qonnx.transformation.infer_shapes import InferShapes
    
    model_wrapper = ModelWrapper("mvdr_opset9W16A16.onnx")
    model_wrapper = model_wrapper.transform(InferShapes())
    print("Modele ONNX Brevitas importe avec succes via QONNX.")
    use_onnx_wrapper = True
else:
    model = MVDR_FFNN().to(device)
    checkpoint = torch.load(checkpoint_name, map_location=device)
    model.load_state_dict(checkpoint)
    model.eval()
    print(f"MODELE PYTORCH CHARGE : {checkpoint_name}")
    use_onnx_wrapper = False

# --- Importation de ta fonction MVDR theorique ---
from MVDR import mvdr_results 

# =============================================================================
# --- 2. CONFIGURATION DE LA TRIADE UNIQUE ET DES PARAMETRES RADAR ---
# =============================================================================

soi_test  = 0.0    # Angle du signal utile (SOI) en degres
soa1_test = -30.0  # Angle du premier brouilleur (SOA1) en degres
soa2_test = 45.0   # Angle du deuxieme brouilleur (SOA2) en degres

Nr = 16  
d = 0.5  
theta_scan_deg = np.linspace(-90, 90, 1000)

# =============================================================================
# --- 3. FONCTIONS UTILITAIRES ---
# =============================================================================
def get_steering_vector(theta_deg, Nr=16, d=0.5):
    theta_rad = np.deg2rad(theta_deg)
    n = np.arange(Nr)
    return np.exp(2j * np.pi * d * n * np.sin(theta_rad))

def get_gain_at_angle(angle_cible, angles_scan, gains_db):
    idx_proche = np.argmin(np.abs(angles_scan - angle_cible))
    return gains_db[idx_proche]

# =============================================================================
# --- 4. INFERENCE DU MODELE ET CALCUL MVDR ---
# =============================================================================

input_np = np.array([[soi_test, soa1_test, soa2_test]], dtype=np.float32) / 60.0

if not use_onnx_wrapper:
    with torch.no_grad():
        input_tensor = torch.tensor(input_np, dtype=torch.float32).to(device)
        sortie = model(input_tensor).cpu().numpy().flatten()
else:
    import qonnx.core.onnx_exec as oxe
    input_dict = {model_wrapper.model.graph.input[0].name: input_np}
    output_dict = oxe.execute_onnx(model_wrapper, input_dict)
    sortie = list(output_dict.values())[0].flatten()

# De-normalisation (*10) et reconstruction des poids complexes
sortie_norm = sortie * 10   
w_nn = sortie_norm[:16] + 1j * sortie_norm[16:]

# Calcul MVDR Theorique
w_mvdr, _ = mvdr_results(soi_test, soa1_test, soa2_test)
w_mvdr = w_mvdr.flatten()

# =============================================================================
# --- 5. CALCUL DES DIAGRAMMES DE RAYONNEMENT ---
# =============================================================================

p_nn = np.array([np.abs(np.vdot(w_nn, get_steering_vector(ang)))**2 for ang in theta_scan_deg])
ref_nn = np.abs(np.vdot(w_nn, get_steering_vector(soi_test)))**2
db_nn_plot = 10 * np.log10(p_nn / ref_nn + 1e-12)

p_mv = np.array([np.abs(np.vdot(w_mvdr, get_steering_vector(ang)))**2 for ang in theta_scan_deg])
ref_mv = np.abs(np.vdot(w_mvdr, get_steering_vector(soi_test)))**2
db_mv_plot = 10 * np.log10(p_mv / ref_mv + 1e-12)

# =============================================================================
# --- 6. TRACE ET SAUVEGARDE DU GRAPHIQUE ---
# =============================================================================
plt.figure(figsize=(12, 6))

plt.plot(theta_scan_deg, db_mv_plot, color='red', label='MVDR theorique', linewidth=2)
plt.plot(theta_scan_deg, db_nn_plot, color='blue', linestyle='--', label='MLP Quantifie W16A16', linewidth=1.8)

triade_angles = [soi_test, soa1_test, soa2_test]
couleurs = ['green', 'orange', 'orange']
labels = ['SOI', 'Brouilleur 1', 'Brouilleur 2']

for j, ang in enumerate(triade_angles):
    g_nn = get_gain_at_angle(ang, theta_scan_deg, db_nn_plot)
    g_mv = get_gain_at_angle(ang, theta_scan_deg, db_mv_plot)
    
    plt.axvline(ang, color=couleurs[j], alpha=0.7, linestyle=':', linewidth=1.5)
    plt.plot(ang, g_nn, 'bo', markersize=6)
    
    plt.annotate(f"{labels[j]} : {ang:.1f}°\nNN: {g_nn:.1f} dB\nMV: {g_mv:.1f} dB", 
                 (ang, g_nn), xytext=(15, -20), 
                 textcoords="offset points", ha='left', fontsize=9, 
                 bbox=dict(boxstyle='round,pad=0.3', fc='white', alpha=0.8, ec='gray'))

plt.title(f"Diagramme de Rayonnement | Modele Quantifie W16A16", fontsize=12)
plt.xlabel("Angle de balayage (degres)", fontsize=10)
plt.ylabel("Gain Spatial Relatif (dB)", fontsize=10)
plt.xlim([-90, 90])
plt.xticks(range(-90, 91, 10))
plt.ylim([-90, 5])
plt.yticks(range(-90, 11, 10))
plt.grid(True, linestyle='-', alpha=0.4)
plt.legend(loc='upper right', fontsize='medium')

plt.tight_layout()

# Generation du nom de fichier unique base sur la triade
filename = f"diagramme_W16A16_soi_{int(soi_test)}_soa1_{int(soa1_test)}_soa2_{int(soa2_test)}.png"
plt.savefig(filename, dpi=300)
print(f"Graphique sauvegarde avec succes sous le nom : {filename}")

plt.show()

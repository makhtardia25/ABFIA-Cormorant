import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import torch
import torch.nn as nn
from torch.utils.data import TensorDataset, DataLoader,Dataset, random_split
from tqdm import tqdm
import torch.nn.functional as F
import time
from datetime import datetime, timedelta

import os
import brevitas.nn as qnn

from brevitas.export import QONNXManager
# On va créer nos propres types 16-bit à partir des types 8-bit de base
# C'est la méthode la plus propre dans Brevitas pour garantir la compatibilité
from brevitas.quant.scaled_int import Int8WeightPerTensorFloat as Int8Weight
from brevitas.quant.scaled_int import Int8ActPerTensorFloat as Int8Act

# Chargement des Data
input_signals = np.load("../Data/X_mvdr_400k.npy")  # Shape attendue: (400000, 3)
output_signals = np.load("../Data/Y_mvdr_400k.npy") # Shape attendue: (400000, 32)

# 3. NORMALISATION DES ANGLES (X)
input_x = torch.from_numpy(input_signals).float() / 60.0
output_x = torch.from_numpy(output_signals).float() * 10

print(input_x.shape)
print(output_x.shape)
# --- CHANGEMENT ICI ---
# On utilise Uint8 comme base pour que FINN accepte la ReLU
from brevitas.quant.scaled_int import Uint8ActPerTensorFloat as Uint8Act

# On garde les poids signés et symétriques (pour l'accumulateur INT32)
class Int16Weight(Int8Weight):
    bit_width = 16
    
class Uint16Act(Uint8Act):
    bit_width = 16


class Int16Act(Int8Act):
    bit_width = 16


# W16A8 (FINN-safe): activations unsigned 8-bit
class Uint8ActQ(Uint8Act):
    bit_width = 8
# 1. Utiliser l'exportateur QONNX (le standard actuel pour FINN)

# --- ARCHITECTURE DU RÉSEAU MVDR ---
class MVDR_FFNN(nn.Module):
    def __init__(self):
        super(MVDR_FFNN, self).__init__()
        
        # W16A8: Entrée du réseau quantifiée en 8-bit unsigned (0 à 255)
        self.quant_input = qnn.QuantIdentity(act_quant=Uint8ActQ, return_quant_tensor=True)

        # On passe Uint8ActQ en input_quant pour forcer le calcul en W16A16
        self.layer1 = qnn.QuantLinear(3, 256, bias=False, weight_quant=Int16Weight, input_quant=Uint8ActQ, narrow_range=True)
        self.relu1  = qnn.QuantReLU(bit_width=8, act_quant=Uint8ActQ)
        
        self.layer2 = qnn.QuantLinear(256, 512, bias=False, weight_quant=Int16Weight, input_quant=Uint8ActQ, narrow_range=True)
        self.relu2  = qnn.QuantReLU(bit_width=8, act_quant=Uint8ActQ)
        
        self.layer3 = qnn.QuantLinear(512, 512, bias=False, weight_quant=Int16Weight, input_quant=Uint8ActQ, narrow_range=True)
        self.relu3  = qnn.QuantReLU(bit_width=8, act_quant=Uint8ActQ)
        
        self.layer4 = qnn.QuantLinear(512, 1024, bias=False, weight_quant=Int16Weight, input_quant=Uint8ActQ, narrow_range=True)
        self.relu4  = qnn.QuantReLU(bit_width=8, act_quant=Uint8ActQ)
        
        # Dernière couche : Reçoit du A8 (Uint8ActQ), possède des poids W16, 
        # et on quantifie sa SORTIE en Int16 (puisqu'un poids MVDR peut être négatif)
        self.layer5 = qnn.QuantLinear(1024, 32, bias=False, weight_quant=Int16Weight, input_quant=Uint8ActQ, narrow_range=True)
        self.quant_output = qnn.QuantIdentity(act_quant=Int16Act, return_quant_tensor=True)
        
    def forward(self, x):
        x = self.quant_input(x)
        
        x = self.relu1(self.layer1(x))
        x = self.relu2(self.layer2(x))
        x = self.relu3(self.layer3(x))
        x = self.relu4(self.layer4(x))
        
        # Inférence de la dernière couche + verrouillage de la précision de sortie
        x = self.quant_output(self.layer5(x))
        return x
        

class RMSELoss(nn.Module):      #<---------------------------------------------
    def __init__(self, eps=1e-8):
        super().__init__()
        self.mse = nn.MSELoss()
        self.eps = eps

    def forward(self, y_hat, y):
        loss = torch.sqrt(self.mse(y_hat, y) + self.eps)
        return loss

# =================================================================================================================

# =================================================================================================================

# Device cuda
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print(device)
# Model
model = MVDR_FFNN().to(device)
#print(model)

# 1. Optimiseur et Perte
criterion = RMSELoss().to(device)
optimizer = torch.optim.AdamW(model.parameters(), lr=5e-4, weight_decay=1e-5)

# 1. Création du Dataset complet
dataset = TensorDataset(input_x, output_x)

# Division 70% Train, 15% Val, 15% Test
train_size = int(0.7 * len(dataset))
val_size = int(0.15 * len(dataset))
test_size = len(dataset) - train_size - val_size
# 2. Division réelle
train_dataset, val_dataset, test_dataset = random_split(dataset, [train_size, val_size, test_size])
# 3. Création des DataLoaders
# Train : Shuffle=True (pour l'apprentissage)
train_loader = DataLoader(train_dataset, batch_size=512, shuffle=True, pin_memory=True)
# Validation : Shuffle=False (pour le suivi du scheduler pendant l'entraînement)
val_loader = DataLoader(val_dataset, batch_size=512, shuffle=False)
# Test : Shuffle=False (pour l'évaluation finale "propre")
test_loader = DataLoader(test_dataset, batch_size=512, shuffle=False)#<---------------------------------------------

# Initialisation
train_losses = []
test_losses = []
epochs = 300  #<---------------------------------------------

# Configuration du Scheduler Cosine
# Il va descendre de façon fluide sans les "marches d'escalier"
scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=1e-7)

start_time = time.time()  # On lance le chrono global
print(f" Début de l'entraînement à : {time.strftime('%H:%M:%S')}")

for epoch in range(epochs):
    # --- PHASE D'ENTRAÎNEMENT ---
    model.train()
    running_train_loss = 0.0
    # On garde tqdm pour la barre de progression par époque
    loop = tqdm(train_loader, desc=f"Époque [{epoch+1}/{epochs}]", leave=False)
    
    for inputs, targets in loop:
        inputs, targets = inputs.to(device), targets.to(device)
        optimizer.zero_grad()
        
        outputs = model(inputs)        
        loss = criterion(outputs, targets)        
        loss.backward()       
        # Evite les explosions de gradient sans casser la dynamique d'apprentissage.
        torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=1.0)
        optimizer.step()
        
        running_train_loss += loss.item()
        loop.set_postfix(loss=f"{loss.item():.2e}")

    epoch_train_loss = running_train_loss / len(train_loader)
    train_losses.append(epoch_train_loss)

    # --- PHASE DE TEST (VALIDATION) ---
    model.eval()
    running_test_loss = 0.0
    with torch.no_grad():
        for inputs, targets in val_loader: 
            inputs, targets = inputs.to(device), targets.to(device)
            outputs = model(inputs)
            loss = criterion(outputs, targets)
            running_test_loss += loss.item()
    
    epoch_test_loss = running_test_loss / len(val_loader)
    test_losses.append(epoch_test_loss)
    
    # Mise à jour du scheduler Cosine (automatique à chaque époque)
    scheduler.step()

    # Récupération du LR actuel pour le suivi
    current_lr = optimizer.param_groups[0]['lr']

    # AFFICHAGE (Indenté à l'intérieur de la boucle pour voir l'évolution)
    # On affiche toutes les époques (ou tu peux mettre un if epoch % 10 == 0:)
    if (epoch + 1) % 10 == 0:
        print(f"Époque [{epoch+1}/{epochs}] | Train: {epoch_train_loss:.6f} | Test: {epoch_test_loss:.6f} | LR: {current_lr:.2e}")

# Calcul du temps total de l'entrainement.
end_time = time.time()
total_duration_seconds = end_time - start_time

# Conversion magique en Heures:Minutes:Secondes
total_time = str(timedelta(seconds=int(total_duration_seconds)))

print("-" * 50)
print(f" ENTRAÎNEMENT TERMINÉ")
print(f" TEMPS TOTAL : {total_time} (HH:MM:SS)")
print("-" * 50)


#===============================================================================================================
#===============================================================================================================

model.eval()
total_mse = 0.0
test_samples_count = 0

all_preds = []
all_targets = []

with torch.no_grad():
    for inputs, targets in test_loader:
        inputs, targets = inputs.to(device), targets.to(device)
        
        # 0. Inférence
        outputs = model(inputs)

        # 1. Normalisation des prédictions (Norme 1)
        normes_out = torch.norm(outputs, p=2, dim=1, keepdim=True)
        outputs_norm = outputs / (normes_out + 1e-12)
        
        # 2. Normalisation des targets (Norme 1) 
        normes_tg = torch.norm(targets, p=2, dim=1, keepdim=True)
        targets_norm = targets / (normes_tg + 1e-12)
        
        # 3. Calcul de la MSE sur ce batch
        mse_batch = torch.mean((outputs_norm - targets_norm)**2)
        
        # --- CORRECTION : Accumulation ---
        total_mse += mse_batch.item() * inputs.size(0)
        test_samples_count += inputs.size(0)
        
        if len(all_preds) < 1: 
            all_preds.append(outputs_norm.cpu().numpy())
            all_targets.append(targets_norm.cpu().numpy()) # On stocke aussi la version normée ici

# --- CALCUL DES MÉTRIQUES FINALES ---
final_mse = total_mse / test_samples_count
final_rmse = np.sqrt(final_mse) # Le RMSE global est la racine de la MSE moyenne

print("-" * 50)
print(f" RÉSULTATS DU TEST FINAL (MODÈLE - INT16)")
print(f" MSE Moyenne (Normalisée)  : {final_mse:.8e}")
print(f" RMSE Globale (Normalisée) : {final_rmse:.8f}")

score_proximite = 100 * (1 - final_rmse)
print(f" Score de fidélité estimé   : {max(0, score_proximite):.2f}%")
print("-" * 50)

#===============================================================================================================
# --- SECTION EXPORT ET PATCH FINAL ---
import onnx
from brevitas.export import QONNXManager

model.eval()
dummy_input = torch.randn(1, 3)

# 1. On définit le chemin une bonne fois pour toutes
export_path = "../models_FFNN_Quantifie/mvdr_opset9.onnx"

# 2. Exportation
QONNXManager.export(
    model.cpu(), 
    input_t=dummy_input, 
    export_path=export_path,
    opset_version=9
)
print(f"Chemin : {export_path}")

#===============================================================================================================

# --- 1. CONFIGURATION DES CHEMINS ---
timestamp = datetime.now().strftime("%Y%m%d_%H%M")
# On change le nom pour préciser que c'est du 16-bit QAT
base_filename = f"Brevitas_QAT_16bit_{timestamp}"

folder_name = "../models_FFNN_Quantifie" # Dossier dédié à la quantification
if not os.path.exists(folder_name):
    os.makedirs(folder_name)

model_path = os.path.join(folder_name, f"{base_filename}_Brevitas_QAT_weights.pth")
plot_path = os.path.join(folder_name, f"{base_filename}_Brevitas_QAT_loss.png")

# --- 2. SAUVEGARDE DES POIDS ---
# On sauvegarde les poids entraînés par la QAT
torch.save(model.state_dict(), model_path)
print(f" MODÈLE QUANTIFIÉ SAUVEGARDÉ : {model_path}")

# --- 3. TRACÉ DE LA COURBE ---
# %matplotlib inline # À utiliser si tu es dans un Notebook

plt.figure(figsize=(12, 6))

# Tracé des pertes
plt.plot(train_losses, label='Train Loss (QAT)', color='#1f77b4', linewidth=3, markersize=4, markevery=max(1, len(train_losses)//10))
plt.plot(test_losses, label='Val Loss (QAT)', color='#ff7f0e', linewidth=2)

# Mise en forme
plt.yscale('log') # Très utile pour voir la précision fine en fin d'entraînement
plt.title(f"Convergence QAT (Brevitas 16-bit) - {timestamp}\nMVDR Architecture256-512-512-1024", fontsize=12)
plt.xlabel("Époques", fontsize=12)
plt.ylabel("Loss (RMSE)", fontsize=12)
plt.grid(True, which="both", alpha=0.5)

# Calcul des scores finaux pour la légende
last_train = train_losses[-1]
last_test = test_losses[-1]
# Note : Ton score de fidélité était de ~96.90%, tu peux l'ajouter manuellement ou le recalculer
plt.legend(title=f"Final Train RMSE: {last_train:.2e}\nFinal Val RMSE: {last_test:.2e}", 
           loc='upper right', frameon=True, shadow=True)

# --- 4. SAUVEGARDE ET AFFICHAGE ---
plt.savefig(plot_path, dpi=150, bbox_inches='tight')
plt.show()

print(f" Graphique de convergence sauvegardé : {plot_path}")



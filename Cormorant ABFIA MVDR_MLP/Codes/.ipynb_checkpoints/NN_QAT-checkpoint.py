import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset
from torch.utils.data import TensorDataset, DataLoader, random_split
import torch.optim as optim
import torch.nn as nn
from tqdm import tqdm
import torch.nn.functional as F
import time
from datetime import datetime, timedelta
import os

from pytorch_nndct.apis import QatProcessor
# C'est l'API spécifique pour PyTorch dans Vitis AI
from pytorch_nndct.apis import torch_quantizer

Nr = 16 # Nombre d'éléments

# Chargement des Data
input_signals = np.load("../Data/X_mvdr_400k.npy")  # Shape attendue: (100000, 3)
output_signals = np.load("../Data/Y_mvdr_400k.npy") # Shape attendue: (100000, 32)

# 3. NORMALISATION DES ANGLES (X)
input_x = torch.from_numpy(input_signals).float() / 60.0
output_x = torch.from_numpy(output_signals).float() * 10

print(f"Poids normalisés. Nouvelle norme moyenne : {torch.norm(output_x[0]):.2f}")
print(input_x.shape)
print(output_x.shape)

# des couches de taille multiple de 32       #<---------------------------------------------
from pytorch_nndct import nn as nndct_nn
timestamp = datetime.now().strftime("%Y%m%d_%H%M")

class MVDR_FFNN(nn.Module):
    def __init__(self):
        super(MVDR_FFNN, self).__init__()
        self.quant = nndct_nn.QuantStub()
        
        self.layer1 = nn.Linear(3, 512)
        self.layer2 = nn.Linear(512, 1024)
        self.layer3 = nn.Linear(1024, 2048)
        self.layer4 = nn.Linear(2048, 1024)
        self.layer5 = nn.Linear(1024, 32)
        
        # On définit 4 instances distinctes En quantification (INT8), 
        # chaque activation possède sa propre échelle de quantification 
        # (scale factor) d'où la définition de 4 au lieu de 1.
        self.relu1 = nn.LeakyReLU(0.1015625) 
        self.relu2 = nn.LeakyReLU(0.1015625)
        self.relu3 = nn.LeakyReLU(0.1015625)
        self.relu4 = nn.LeakyReLU(0.1015625)
        
        self.dequant = nndct_nn.DeQuantStub()

        # Initialisation automatique
        for m in self.modules():
            if isinstance(m, nn.Linear):
                nn.init.kaiming_uniform_(m.weight, a=0.1015625, nonlinearity='leaky_relu')
                if m.bias is not None:
                    nn.init.constant_(m.bias, 0)
        
    def forward(self, x):
        x = self.quant(x)
        # On utilise chaque instance une seule fois
        x = self.relu1(self.layer1(x))
        x = self.relu2(self.layer2(x))
        x = self.relu3(self.layer3(x))
        x = self.relu4(self.layer4(x))
        x = self.layer5(x)
        x = self.dequant(x)
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
print(model)

dummy_input = torch.randn(1, 3).to(device)    #<---------------------------------------------

# 2. Créer le processeur QAT
# bitwidth=8 pour le DPU de la KR260 sur 8 bit
qat_processor = QatProcessor(model, dummy_input, bitwidth=8, device=device)

# 3. Obtenir le modèle "prêt pour le QAT"
qat_model = qat_processor.trainable_model()   # C'est LUI le nouveau modèle


# 1. Création du Dataset complet
dataset = TensorDataset(input_x, output_x)     
# Division 70% Train, 15% Val, 15% Tes
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
test_loader = DataLoader(test_dataset, batch_size=512, shuffle=False) #<---------------------------------------------

epochs = 400  #<---------------------------------------------

# AdamW avec un Learning Rate standard
# Modification avec qat_model :
optimizer = torch.optim.AdamW(qat_model.parameters(), lr=0.001)        #<---------------------------------------------
# Utilisation de la MSE (Mean Squared Error) pour comparer les poids
criterion = RMSELoss()
# Configuration du Scheduler Cosine
# Il va descendre de façon fluide sans les "marches d'escalier"
scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=1e-7)
# =================================================================================================================

# =================================================================================================================

# Initialisation
train_losses = []
test_losses = []

start_time = time.time()  # On lance le chrono global
print(f" Début de l'entraînement à : {time.strftime('%H:%M:%S')}")

for epoch in range(epochs):
    # --- PHASE D'ENTRAÎNEMENT ---
    qat_model.train()
    running_train_loss = 0.0
    # On garde tqdm pour la barre de progression par époque
    loop = tqdm(train_loader, desc=f"Époque [{epoch+1}/{epochs}]", leave=False)
    
    for inputs, targets in loop:
        inputs, targets = inputs.to(device), targets.to(device)
        optimizer.zero_grad()
        
        outputs = qat_model(inputs)        
        loss = criterion(outputs, targets)        
        loss.backward()       
        optimizer.step()       
        
        running_train_loss += loss.item()
        loop.set_postfix(loss=f"{loss.item():.2e}")

    epoch_train_loss = running_train_loss / len(train_loader)
    train_losses.append(epoch_train_loss)

    # --- PHASE DE TEST (VALIDATION) ---
    qat_model.eval()
    running_test_loss = 0.0
    with torch.no_grad():
        for inputs, targets in val_loader: 
            inputs, targets = inputs.to(device), targets.to(device)
            outputs = qat_model(inputs)
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
    if (epoch + 1) % 1 == 0:
        print(f"Époque [{epoch+1}/{epochs}] | Train: {epoch_train_loss:.6f} | Test: {epoch_test_loss:.6f} | LR: {current_lr:.2e}")

# Calcul du temps total de l'entrainement.
end_time = time.time()
total_duration_seconds = end_time - start_time

# Conversion magique en Heures:Minutes:Secondes
total_time = str(timedelta(seconds=int(total_duration_seconds)))

print("-" * 50)
print(f" ENTRAÎNEMENT TERMINÉ")
print(f" TEMPS TOTAL : {total_time} (HH:MM:SS)")
# =================================================================================================================
                                    # PHASE critique
# =================================================================================================================
# 1. Nettoyage et préparation
output_dir = "qat_results/"
if os.path.exists(output_dir):
    import shutil
    shutil.rmtree(output_dir) # On rase tout pour éviter les conflits de taille
os.makedirs(output_dir)

# --- APRÈS L'ENTRAÎNEMENT ---
print("Conversion vers le modèle déployable...")

# Au lieu de convert_to_deployable, on utilise to_deployable 
# Cette méthode retourne directement l'objet modèle ET crée les fichiers .pth
deployable_model = qat_processor.to_deployable(qat_model, output_dir) #<------ Trés important -------
deployable_model.eval().cpu()

# 3. TRACING (Indispensable pour générer le .xmodel)
input_data, _ = test_dataset[0]
input_data = input_data.unsqueeze(0).cpu()

print("Tracing du modèle...")
with torch.no_grad():
    deployable_model(input_data)

# 4. EXPORTATION FINALE POUR LA KR260
print("Génération du .xmodel...")
qat_processor.export_xmodel(output_dir=output_dir)

# 6. L'exportation finale vers le format matériel Xilinx
print("Génération du .xmodel...")
qat_processor.export_xmodel(output_dir=output_dir)

# 7. Vérification
files = os.listdir(output_dir)
print(f"\nFichiers générés : {files}")
# =================================================================================================================
                                    # PHASE DE TEST FINAL (RÉGRESSION MVDR)
# =================================================================================================================

# --- INITIALISATION ---
total_mse = 0.0  # Correction du nom (MSE et non RMSE)
test_samples_count = 0

all_preds = []
all_targets = []

print(f"\n Test final sur l'ensemble de TEST ({len(test_dataset)} échantillons)...")

# Utilisation du modèle DÉPLOYABLE (INT8 simulé)
deployable_model.eval() 

with torch.no_grad():
    for inputs, targets in test_loader:
        # Transfert CPU/GPU selon ta config (ici on reste cohérent avec le tracing)
        inputs = inputs.to(device)
        targets = targets.to(device)
        
        # 0. Inférence avec le modèle QUANTIFIÉ
        outputs = deployable_model(inputs)

        # 1. Normalisation des prédictions (Vecteur unitaire)
        # On utilise la norme L2 pour comparer la "forme" du faisceau
        normes_out = torch.norm(outputs, p=2, dim=1, keepdim=True)
        outputs_norm = outputs / (normes_out + 1e-12)
        
        # 2. Normalisation des targets 
        normes_tg = torch.norm(targets, p=2, dim=1, keepdim=True)
        targets_norm = targets / (normes_tg + 1e-12)
        
        # 3. Calcul de la MSE sur les vecteurs unitaires
        # Cela mesure si le modèle pointe dans la bonne direction
        mse_batch = torch.mean((outputs_norm - targets_norm)**2)
        
        # 4. Accumulation pondérée
        total_mse += mse_batch.item() * inputs.size(0)
        test_samples_count += inputs.size(0)
        
        # Stockage pour affichage futur
        if len(all_preds) < 1: 
            all_preds.append(outputs_norm.cpu().numpy())
            all_targets.append(targets_norm.cpu().numpy())

# --- CALCUL DES MÉTRIQUES FINALES ---
final_mse = total_mse / test_samples_count
final_rmse = np.sqrt(final_mse)

# --- TRACÉ DES COURBES (Ton code est bon ici) ---
plt.figure(figsize=(10, 6))
plt.plot(train_losses, label=f'Train RMSE (Final: {train_losses[-1]:.4f})', color='blue')
plt.plot(test_losses, label=f'Test RMSE (Final: {test_losses[-1]:.4f})', color='orange')
plt.yscale('log')
plt.title(f"Convergence QAT - MVDR \nRMSE Finale: {final_rmse:.6f}")
plt.xlabel("Époques")
plt.ylabel("RMSE (Échelle Log)")
plt.legend()
plt.grid(True, which="both", alpha=0.3)

plot_path = os.path.join("../models_FFNN_Quanti", f"QAT_512-1024-2048-1024_Loss_{timestamp}.png")
plt.savefig(plot_path, dpi=150)
plt.show()
print(f"Graphique sauvegardé : {plot_path}")
print("-" * 60)
print(f" RÉSULTATS DU TEST FINAL (SIMULATION INT8 VIA QAT)")
print(f" RMSE Moyenne : {final_rmse:.8f}")
print(f" MSE Moyenne  : {final_mse:.8e}")

# Score de fidélité (Interprétation pour ton rapport)
score_proximite = 100 * (1 - final_rmse)
print(f"🔹 Score de fidélité estimé : {max(0, score_proximite):.2f}%")
print("-" * 60)
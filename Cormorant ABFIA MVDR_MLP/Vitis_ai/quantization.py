import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import TensorDataset
import argparse
import os
import glob
import numpy as np
import time
from datetime import timedelta
# C'est l'API spécifique pour PyTorch dans Vitis AI
from pytorch_nndct.apis import torch_quantizer

# --- 1. Définition de l'Architecture (Identique à l'entraînement) ---   lol
class MVDR_FFNN(nn.Module):
    def __init__(self):
        super(MVDR_FFNN, self).__init__()
        self.layer1 = nn.Linear(3, 256)
        self.layer2 = nn.Linear(256, 512)
        self.layer3 = nn.Linear(512, 512)
        self.layer4 = nn.Linear(512, 1024)
        self.layer5 = nn.Linear(1024, 32) # Dernière couche 
        
    def forward(self, x):
        # 1. Les L-1 premières couches cachées leaky_relu  x = F.leaky_relu(self.layer1(x), 0.1)
        x = F.leaky_relu(self.layer1(x), 0.1)
        x = F.leaky_relu(self.layer2(x), 0.1)
        x = F.leaky_relu(self.layer3(x), 0.1)
        x = F.leaky_relu(self.layer4(x), 0.1)
               
        x = self.layer5(x)        
        return x

def quantization(args):
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

    # --- 2. Chargement des données ---
    input_signals = np.load("../Data/X_mvdr_400k.npy")
    output_signals = np.load("../Data/Y_mvdr_400k.npy")

    # NORMALISATION DES POIDS (Y)
    normes = np.linalg.norm(output_signals, axis=1, keepdims=True)
    output_signals = output_signals / (normes + 1e-12)
    
    # NORMALISATION ANGLES (X)
    input_x = torch.from_numpy(input_signals).float() / 60.0
    output_x = torch.from_numpy(output_signals).float()

    # --- 3. Chargement du Modèle ---
    model = MVDR_FFNN().to(device)
    checkpoint_dir = "../models_FFNN"
    list_of_files = glob.glob(os.path.join(checkpoint_dir, "*.pth"))
    if not list_of_files:
        raise FileNotFoundError("Aucun fichier .pth trouvé.")
    
    latest_model_path = max(list_of_files, key=os.path.getctime)
    checkpoint = torch.load(latest_model_path, map_location=device)
    model.load_state_dict(checkpoint)
    model.eval()
    print(f" Modèle chargé : {os.path.basename(latest_model_path)}")

    # --- 4. Initialisation du Quantizer ---
    dummy_input = torch.randn(1, 3).to(device) 

    #=============================================================================
    # quantizer = torch_quantizer(quant_mode, model, (input)) fonction de base 
    # de la quantization par Vitis ai quant_model = quantizer.quant_model
    #=============================================================================
    quantizer = torch_quantizer(
        args.quant_mode, 
        model, 
        (dummy_input,), 
        output_dir=args.quant_dir, 
        device=device
    )
    quant_model = quantizer.quant_model

    # --- 5. Boucle de Calibration / Test + RMSE ---
    # Pour la calibration, 1000 échantillons suffisent.
    # Pour le test, on peut en prendre plus pour avoir une RMSE fiable.
    num_samples = 1000 if args.quant_mode == 'calib' else 5000 
    print(f" Running in mode: {args.quant_mode} on {num_samples} samples")
    
    all_preds = []
    all_targets = []

    with torch.no_grad():
        for i in range(num_samples):
            batch_x = input_x[i].unsqueeze(0).to(device)
            batch_y = output_x[i].unsqueeze(0).to(device)
            
            output = quant_model(batch_x)
            
            # Stockage pour calcul RMSE (uniquement en mode test)
            if args.quant_mode == 'test':
                all_preds.append(output.cpu().numpy())
                all_targets.append(batch_y.cpu().numpy())

            if i % 200 == 0:
                print(f"Sample {i} processed...")

    # --- CALCUL DE LA MÉTRIQUE (Uniquement en mode TEST) ---
    if args.quant_mode == 'test':
        preds = np.vstack(all_preds)
        targets = np.vstack(all_targets)
        
        # On normalise les prédictions (comme on le feras sur KR260)
        p_normes = np.linalg.norm(preds, axis=1, keepdims=True)
        preds_norm = preds / (p_normes + 1e-12)
        
        rmse_quant = np.sqrt(np.mean((preds_norm - targets)**2))
        print("\n" + "="*50)
        print(f" RÉSULTAT DE LA QUANTIFICATION (SIMULÉE INT8)")
        print(f" RMSE Quantifiée : {rmse_quant:.8f}")
        print("="*50 + "\n")

# --- 5. Boucle de Calibration / Finetuning ---
    if args.quant_mode == 'calib':
        if args.fast_finetune:
            print("🚀 Démarrage du Fast Finetuning (AdaQuant)...")
            # On définit une fonction pour que le quantizer puisse itérer sur les données
            def fast_finetune_iter(model, train_loader):
                for i in range(100): # 100 itérations suffisent généralement
                    batch_x = input_x[i*10 : (i+1)*10].to(device)
                    model(batch_x)

            # Appel de l'API Vitis AI
            quantizer.fast_finetune(fast_finetune_iter, (quant_model, None))
        else:
            # Calibration normale
            with torch.no_grad():
                for i in range(1000):
                    batch_x = input_x[i].unsqueeze(0).to(device)
                    quant_model(batch_x)
        # utilisation : python3 quantization.py --quant_mode calib --fast_finetune
        quantizer.export_quant_config()
    
    if args.quant_mode == 'test' and args.deploy:
        print(" Exporting xmodel for KV 260...")
        quantizer.export_xmodel(output_dir=args.quant_dir, deploy_check=True)
        # utilisation : python3 quantization.py --quant_mode test --deploy
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--quant_mode', default='calib', choices=['calib', 'test'], help='Mode')
    parser.add_argument('--quant_dir', default='quantized_results', help='Dossier de sortie')
    parser.add_argument('--deploy', action='store_true', help='Export xmodel')
    # LIGNE ajouté:
    parser.add_argument('--fast_finetune', action='store_true', help='Activer AdaQuant')
    
    args = parser.parse_args()
    quantization(args)
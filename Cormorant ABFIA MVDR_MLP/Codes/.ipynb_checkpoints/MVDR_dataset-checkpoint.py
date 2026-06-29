# %%
import numpy as np
import matplotlib.pyplot as plt
from Make_dataset_mvdr import generate_mvdr_dataset

# 1. Génération (Test avec K=200000 pour une précision maximale)
N_samples = 400000
Nr = 16
K = 10000
d = 0.5
X_data, Y_data = generate_mvdr_dataset(N_samples, Nr, K, d)

print(f"Dataset généré : Entrées {X_data.shape}, Sorties {Y_data.shape}")

# 2. Visualisation d'un échantillon aléatoire pour validation
idx = np.random.randint(0, N_samples)
theta_soi, theta_soa1, theta_soa2 = X_data[idx]
w_flat = Y_data[idx]

# Reconstruction du vecteur de poids complexe (16 réels + 16 imaginaires)
w = w_flat[:Nr] + 1j * w_flat[Nr:]

# Calcul du diagramme de rayonnement pour vérification
theta_scan = np.linspace(-90, 90, 1000)
theta_scan_rad = np.deg2rad(theta_scan)
# Steering vector matrix pour le scan
A_scan = np.exp(2j * np.pi * d * np.arange(Nr).reshape(-1, 1) * np.sin(theta_scan_rad))
pattern = np.abs(w.conj().T @ A_scan).flatten()**2
pattern_db = 10 * np.log10(pattern / np.max(pattern) + 1e-12)

# 3. Vérification des statistiques simples
print(f"Moyenne partie réelle : {np.mean(w_flat[:Nr]):.4f}")
print(f"Moyenne partie imaginaire : {np.mean(w_flat[Nr:]):.4f}")

# 4. Sauvegarde des fichiers
np.save('../Data/X_mvdr_400k.npy', X_data)
np.save('../Data/Y_mvdr_400k.npy', Y_data)
print("Dataset sauvegardé avec succès !")

# Affichage
plt.figure(figsize=(10, 5))
plt.plot(theta_scan, pattern_db, color='red', alpha=0.6, label='Diagramme MVDR (Dataset)')
plt.axvline(theta_soi, color='g', linestyle='--', label=f'SOI ({theta_soi:.2f}°)')
plt.axvline(theta_soa1, color='orange', linestyle=':', label=f'SOA1 ({theta_soa1:.2f}°)')
plt.axvline(theta_soa2, color='orange', linestyle=':', label=f'SOA2 ({theta_soa2:.2f}°)')

plt.title(f"Vérification Échantillon n°{idx}")
plt.xlabel("Angle (degrés)")
plt.ylabel("Gain (dB)")
plt.xlim([-90, 90])
plt.ylim([-100, 2])
plt.xticks(range(-90, 91, 10))
plt.grid(True, linestyle='-', alpha=0.4)
plt.legend()
plt.show()

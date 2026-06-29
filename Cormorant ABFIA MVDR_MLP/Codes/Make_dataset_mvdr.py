import numpy as np
import time  # <--- Étape 1 : Importer le module time

def steering(theta, Nr, d):
    """Calcule le vecteur directeur pour une ULA (Vectorisé)."""
    n = np.arange(Nr).reshape(-1, 1)
    return np.exp(2j * np.pi * d * n * np.sin(theta))

def calculate_output_sinr(w, a_soi, R_tr, P_soi):
    """
    Calcule le SINR de sortie en dB.
    w : vecteur de poids complexes (Nr, 1)
    a_soi : vecteur directeur de la cible (Nr, 1)
    R_tr : matrice de covariance (Interférences + Bruit)
    P_soi : puissance de l'écho cible
    """
    # 1. Puissance du signal utile en sortie : P_soi * |w^H * a_soi|^2
    # En MVDR, w^H * a_soi = 1, donc S_out devrait être égal à P_soi
    S_out = P_soi * np.abs(w.conj().T @ a_soi)**2
    
    # 2. Puissance totale des résidus (Brouilleurs + Bruit) en sortie
    # Formule : w^H * R_i+n * w
    I_N_out = np.real(w.conj().T @ R_tr @ w)
    
    # 3. Calcul du rapport
    sinr_linear = S_out / I_N_out
    #  On utilise .item() pour être sûr d'avoir un nombre (float) 
    # et non un tableau numpy (array)
    return (10 * np.log10(sinr_linear)).item()

# ======================================================================
# Génération du dataset avec generate_mvdr_dataset(N_samples, Nr, K, d) 
# ======================================================================

def generate_mvdr_dataset(N_samples, Nr, K, d):
    """
    Génère un dataset MVDR réaliste avec filtrage de précision.
    """
    # --- Étape 2 : Lancer le chrono ---
    start_time = time.time()
    dataset_inputs = []
    dataset_outputs = []
    
    # Paramètres de puissance fixes
    P_soi, P_int1, P_int2, P_noise =1, 0.5, 1.0, 0.03  # P_soi est utilisé seulement pour calculer le SINR
    sample_rate = 1e6
    t = np.arange(K) / sample_rate
    
    # Seuils de notre model
    peak_tol = 0.2   # Divergence max lobe principal
    null_tol = 0.05   # Divergence max placement des zéros
    
    # Axe de scan haute résolution pour la validation (pas de 0.05°)
    theta_scan_deg = np.arange(-90, 90.01, 0.05)
    theta_scan_rad = np.deg2rad(theta_scan_deg)
    A_scan = steering(theta_scan_rad, Nr, d) # (Nr, 3601)

    attempts = 0
    print(f"--- Démarrage de la génération : Objectif {N_samples} échantillons ---")

    while len(dataset_inputs) < N_samples:
        attempts += 1
        
        # 1. Tirage aléatoire des angles (SoI et 2 SoA)
        angles_deg = np.random.uniform(-60, 60, 3)
        th_soi_deg, th_soa1_deg, th_soa2_deg = angles_deg

        # Séparation minimale pour éviter les singularités matricielles
        if np.min(np.abs(np.diff(np.sort(angles_deg)))) < 5:
            continue

        # 2. Génération des signaux (Interférences + Bruit)
        theta_rad = np.deg2rad(angles_deg)
        a_soi = steering(theta_rad[0], Nr, d)
        a_i1  = steering(theta_rad[1], Nr, d)
        a_i2  = steering(theta_rad[2], Nr, d)

        # Fréquences aléatoires pour éviter le sur-apprentissage temporel
        f1, f2 = np.random.uniform(0.01e6, 0.05e6, 2)
        
        int1 = a_i1 @ (np.sqrt(P_int1) * np.exp(2j * np.pi * f1 * t).reshape(1, -1))
        int2 = a_i2 @ (np.sqrt(P_int2) * np.exp(2j * np.pi * f2 * t).reshape(1, -1))
        noise = (np.random.randn(Nr, K) + 1j * np.random.randn(Nr, K)) / np.sqrt(2)
        noise *= np.sqrt(P_noise)

        # Matrice de covariance sur interférences + bruit seulement (X_tr)
        X_tr = int1 + int2 + noise
        R_tr = (X_tr @ X_tr.conj().T) / K
        R_tr += 1e-8 * np.eye(Nr) # Diagonal loading pour la stabilité

        try:
            # 3. Calcul des poids MVDR
            Rinv = np.linalg.pinv(R_tr)
            w = (Rinv @ a_soi) / (a_soi.conj().T @ Rinv @ a_soi)

            #--- NOUVELLE ÉTAPE : CALCUL DU SINR ---
            current_sinr_db = calculate_output_sinr(w, a_soi, R_tr, P_soi)

            # 4. Vérification du diagramme (Critères de l'article)
            pattern = np.abs(w.conj().T @ A_scan).flatten()**2
            
            # A. Vérification du Lobe Principal
            peak_idx = np.argmax(pattern)
            peak_angle = theta_scan_deg[peak_idx]
            cond_peak = abs(peak_angle - th_soi_deg) <= peak_tol

            # B. Vérification des Zéros (Nulls)
            def check_null(target_angle):
                # On cherche le minimum local dans une fenêtre de +/- 1°
                mask = (theta_scan_deg > target_angle - 1.0) & (theta_scan_deg < target_angle + 1.0)
                if not np.any(mask): return False
                actual_null_angle = theta_scan_deg[mask][np.argmin(pattern[mask])]
                return abs(actual_null_angle - target_angle) <= null_tol

            cond_null1 = check_null(th_soa1_deg)
            cond_null2 = check_null(th_soa2_deg)

            # 5. Validation finale
            if cond_peak and cond_null1 and cond_null2:
                dataset_inputs.append([th_soi_deg, th_soa1_deg, th_soa2_deg])
                # Format de sortie : 32 neurones (16 Réels, 16 Imaginaires)
                w_flat = np.concatenate([np.real(w).flatten(), np.imag(w).flatten()])
                dataset_outputs.append(w_flat)

                # Affichage de la progression
                if len(dataset_inputs) % 1000 == 0:
                    acc_rate = (len(dataset_inputs) / attempts) * 1000
                    elapsed = time.time() - start_time
                    percent = (len(dataset_inputs * 100))/N_samples
                    print(f"Progression: {percent} % | Acceptation: {acc_rate:.1f}% | Dernier SINR: {current_sinr_db:.2f} dB | Temps: {elapsed:.1f}s")

        except np.linalg.LinAlgError:
            continue

 # --- Étape 3 : Arrêter le chrono et calculer la durée ---
    end_time = time.time()
    total_duration = end_time - start_time
    
    print(f"\n--- Génération terminée en {attempts} tentatives ---")
    print(f"Temps total : {total_duration:.2f} secondes")
    print(f"Temps moyen par échantillon valide : {total_duration / N_samples:.4f} secondes")

    return np.array(dataset_inputs), np.array(dataset_outputs)
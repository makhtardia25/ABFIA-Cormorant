import numpy as np

def get_steering_vector(theta_deg, Nr=16, d=0.5):
    """Génère le vecteur directeur pour un angle donné."""
    theta_rad = np.deg2rad(theta_deg)
    n = np.arange(Nr)
    return np.exp(2j * np.pi * d * n * np.sin(theta_rad))

def mvdr_results(soi_deg, soa1_deg, soa2_deg, Nr=16, d=0.5, K=10000):
    """
    Calcule les poids MVDR et le SINR associé pour une triade d'angles.
    """
    # --- Configuration interne ---
    sample_rate = 1e6
    t = np.arange(K) / sample_rate
    P_soi, P_int1, P_int2, P_noise = 1, 0.5, 1, 0.03

    # --- Sous-fonction de calcul mathématique (Capon) ---
    def w_mvdr_training(theta_0_rad, X):
        a = np.exp(2j * np.pi * d * np.arange(Nr) * np.sin(theta_0_rad)).reshape(-1, 1)
        R = (X @ X.conj().T) / K
        Rinv = np.linalg.pinv(R)
        w = (Rinv @ a) / (a.conj().T @ Rinv @ a)
        return w

    # --- Préparation des vecteurs et signaux ---
    theta_0 = np.deg2rad(soi_deg)
    
    # Steering vectors
    a1 = get_steering_vector(soi_deg, Nr, d).reshape(-1, 1)
    a2 = get_steering_vector(soa1_deg, Nr, d).reshape(-1, 1)
    a3 = get_steering_vector(soa2_deg, Nr, d).reshape(-1, 1)

    # Signaux temporels
    soi_signal = a1 @ (np.sqrt(P_soi) * np.exp(2j * np.pi * 0.01e6 * t).reshape(1, -1))
    int1 = a2 @ (np.sqrt(P_int1) * np.exp(2j * np.pi * 0.02e6 * t).reshape(1, -1))
    int2 = a3 @ (np.sqrt(P_int2) * np.exp(2j * np.pi * 0.03e6 * t).reshape(1, -1))
    
    # Bruit blanc complexe
    noise = (np.random.randn(Nr, K) + 1j * np.random.randn(Nr, K)) / np.sqrt(2) * np.sqrt(P_noise)

    # Matrice d'observation (Interférences + Bruit uniquement pour le calcul de R)
    X_interference_noise = (int1 + int2) + noise

    # --- Calcul du vecteur de poids ---
    w_mvdr = w_mvdr_training(theta_0, X_interference_noise)

    # --- Calcul du SINR de sortie ---
    y_soi = w_mvdr.conj().T @ soi_signal
    y_int_noise = w_mvdr.conj().T @ X_interference_noise
    
    P_soi_out = np.mean(np.abs(y_soi)**2)
    P_int_noise_out = np.mean(np.abs(y_int_noise)**2)
    sinr_out_db = 10 * np.log10(P_soi_out / (P_int_noise_out + 1e-12))

    return w_mvdr.flatten(), sinr_out_db
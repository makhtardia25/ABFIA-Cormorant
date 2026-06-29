import subprocess
import time
import sys
import os
import shutil

def main():
    # --- CONFIGURATION ---
    heures = 1
    minutes = 15  # Un peu de marge pour être sûr que l'actuel est fini
    dossier_source = "qat_results"
    dossier_destination = "qat_results_copy_athome"
    # ---------------------

    total_secondes = (heures * 3600) + (minutes * 60)
    
    print(f"Attente programmée de {heures}h {minutes}min.")
    print(f"Ordre des opérations : Attendre -> Sauvegarder -> Relancer.")
    
    try:
        # 1. LE DÉCOMPTE (On attend que l'entraînement actuel finisse)
        start_time = time.time()
        while True:
            ecoule = time.time() - start_time
            restant = total_secondes - ecoule
            
            if restant <= 0:
                break
                
            temps_format = time.strftime('%H:%M:%S', time.gmtime(restant))
            sys.stdout.write(f"\rTemps restant avant sauvegarde et relance : {temps_format} ")
            sys.stdout.flush()
            time.sleep(1)
            
        print("\n\nTemps écoulé !")

        # 2. LA SAUVEGARDE (Après le chrono)
        print(f"Sauvegarde de {dossier_source} vers {dossier_destination}...")
        if os.path.exists(dossier_source):
            if os.path.exists(dossier_destination):
                shutil.rmtree(dossier_destination)
            shutil.copytree(dossier_source, dossier_destination)
            print("Sauvegarde effectuée avec succès.")
        else:
            print(f"Erreur : Le dossier {dossier_source} n'a pas été trouvé.")

        # 3. RELANCE DE L'ENTRAÎNEMENT
        print("Lancement de la commande : python3 NN_QAT.py")
        subprocess.run(["python3", "NN_QAT.py"])
        
    except KeyboardInterrupt:
        print("\n\nLancement annulé par l'utilisateur.")

if __name__ == "__main__":
    main()
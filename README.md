# ABFIA-Cormorant
Antibrouillage spatial adaptatif en radar en utilisant un réseau de neurone.

Les théâtres d'opérations militaires contemporains sont caractérisés par une augmentation critique de la densité électromagnétique. Les tensions
internationales actuelles placent le brouillage de radar au centre des conflits, faisant de la maîtrise de cet environnement un facteur clé de
la supériorité tactique. Les forces adverses déploient désormais des techniques de brouillage intentionnel ou non intentionnel conçues
spécifiquement pour paralyser les récepteurs.

Dans ce contexte de forte contestation, notamment le long des routes maritimes stratégiques et des zones de conflits de haute intensité, les 
radars militaires doivent maintenir leurs capacités de détection, d'écoute et de suivi de cibles. Il est crucial pour la survie des plateformes de réussir
où suivre une cible et à atténuer efficacement ces émissions perturbatrices.

L'approche proposée au cours de ce projet consiste à remplacer le calcul numérique lourd des filtres classiques par une approximation neuronale
basée sur une architecture de Deep Learning. Elle consiste à entraîner un réseau de neurones profond à prédire directement les poids complexes optimaux à partir
de la configuration angulaire de l'environnement pour suivre une direction d'intérêt (SOI) et placer des zéros dans les directions des 
brouilleurs (SOA). Le modèle final, optimisé et quantifié, devient alors exécutable sous la forme d'une inférence rapide sur un FPGA.

Ce dépot s'articule autour des deux grandes phases qui ont jalonné ce travail. La première partie dresse l'état de l'art algorithmique (LMS, MVDR),
valide l'environnement de simulation sous PySDR et pose les fondations de la modélisation en précision flottante du réseau de neurones. La seconde
partie du document est quant à elle dédiée à l'exploration matérielle, détaillant les méthodologies de quantification, l'intégration sur cibles
physiques AMD/Xilinx ainsi que les architectures et ruptures envisagées.

Résumé des commandes Pour crée une connexion ssh de serveur a client:

Installer SSH :
Serveur : sudo apt-get install openssh-server
Client : sudo apt-get install openssh-client

Serveur: Générer des clés SSH : ssh-keygen -t rsa -b 4096 -C

Serveur: Mettre en place un agent ssh: eval $(ssh-agent -s)

Serveur: Ajout de la clé privé a l'agent: ssh-add ~/.ssh/id_rsa

Serveur: Vérifier que la clé a bien etait ajouté: ssh-add ~/.ssh/id_rsa

Serveur: Copier la clé publique sur le pc client : ssh-copy-id utilisateur@adresse_ip_du_serveur

Serveur: connexion en ssh depuis le serveur: ssh utilisateur@adresse_ip_du_serveur

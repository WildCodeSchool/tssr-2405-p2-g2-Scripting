Résumé des commandes Pour crée une connexion ssh de serveur a client:

Installer SSH :
Serveur : sudo apt-get install openssh-server
Client : sudo apt-get install openssh-client
Générer des clés SSH :
Client : ssh-keygen -t rsa -b 4096 -C "votre_email@example.com"
Copier la clé publique sur le serveur :
Client : ssh-copy-id utilisateur@adresse_ip_du_serveur
Connexion au serveur :
Client : ssh utilisateur@adresse_ip_du_serveur

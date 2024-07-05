# Documentation du Projet de Gestion de Tâches à Distance via Script

## Prérequis Techniques

### Matériel
- Machines distantes connectées sur le même réseau.
- Machine locale pour l'exécution des scripts.

### Logiciel
- **Systèmes d'exploitation** :
  - OS : Windows Server
  - Version : 2022
  - OS : Windows 
  - Version : 10
- **Langages de script** :
  - Powershell
  - Bash
- **Outils et dépendances** :
  - OpenSSH (pour les connexions SSH)
  - Git (pour le contrôle de version)
  - 
- **Permissions** :
  - Accès administrateur sur les machines distantes pour exécuter certaines tâches.

## Étapes d'Installation et de Configuration

### 1. Préparation de l'Environnement

#### a. Configurations des clients

- Client Windows 10 
- Nom : CLIWIN01
- Compte utilisateur : wilder (dans le groupe des admins locaux)
- Mot de passe : Azerty1*
- Adresse IP fixe : 192.168.1.40

 #### b. Configurations des serveurs
 
- Serveur Windows Server 2022 :
- Nom : SRVWIN01
- Compte : Administrator (dans le groupe des admins locaux)
- Mot de passe : Azerty1*
- Adresse IP fixe : 192.168.1.43
  
 #### c. Configurations des adresses IP fixe pour la mise en réseau

 - Configuration de l'IP statique sur Windows Server et Windows 10 en interface graphique

1. **Ouvrir le Centre Réseau et Partage :**
   - Cliquez sur l'icône réseau dans la barre des tâches.
   - Sélectionnez "Centre Réseau et partage".

2. **Modifier les paramètres de l'adaptateur :**
   - Dans le panneau de gauche, cliquez sur "Modifier les paramètres de la carte".

3. **Sélectionner l'adaptateur réseau :**
   - Faites un clic droit sur l'adaptateur réseau que vous souhaitez configurer.
   - Sélectionnez "Propriétés".
     
![Choix de l'adaptateur](Images/Mise_en_reseaux.png)

4. **Configurer TCP/IPv4 :**
   - Dans la liste, sélectionnez "Protocole Internet version 4 (TCP/IPv4)".
   - Cliquez sur "Propriétés".
  
![ConfigTCP/IP](Images/mise_en_reseaux_2.png)

5. **Entrer les informations IP :**
   - Sélectionnez "Utiliser l'adresse IP suivante".
   - Entrez l'adresse IP : `192.168.1.40`. pour le Windows client et `192.168.1.43` pour le Windows Server
   - Masque de sous-réseau : `255.255.255.0` 
   - Passerelle par défaut : entrez l'adresse IP de votre routeur (par exemple, `192.168.1.254`).

6. **Configurer les serveurs DNS :**
   - Serveurs DNS préféré  `192.168.1.254` 

![ConfigManuelIp](Images/mise_en_reseaux_3.png)

7. **Valider les paramètres :**
   - Cliquez sur "OK" pour fermer les fenêtres de propriétés.
   - Cliquez sur "Fermer" pour terminer la configuration.

 #### d. Configurations des pare-feu pour la connectivité
## Pour Windows

1. **Ouvrir le Pare-feu Windows avec fonctions avancées de sécurité :**
   - Cliquez sur le bouton Démarrer et tapez "Pare-feu Windows avec fonctions avancées de sécurité".
   - Cliquez sur l'application correspondante pour l'ouvrir.

2. **Créer une règle entrante pour ICMP :**
   - Dans le panneau de gauche, cliquez sur "Règles de trafic entrant".
   - Dans le panneau de droite, cliquez sur "Nouvelle règle...".
   - Sélectionnez "Personnalisée" et cliquez sur "Suivant".
   - Sélectionnez "Tous les programmes" et cliquez sur "Suivant".
   - Sélectionnez "Type de protocole" et choisissez "ICMPv4" dans le menu déroulant.
   - Cliquez sur "Suivant".
   - Sélectionnez "Adresse IP source" pour définir les adresses spécifiques ou laissez "Toutes les adresses" pour permettre les pings de n'importe quelle source.
   - Cliquez sur "Suivant".
   - Sélectionnez "Autoriser la connexion".
   - Cliquez sur "Suivant".
   - Choisissez les profils pour lesquels cette règle s'applique (Domaine, Privé, Public).
   - Cliquez sur "Suivant".
   - Donnez un nom à la règle (par exemple, "Autoriser ICMPv4 Entrant") et cliquez sur "Terminer".
  
  #### e. Installation et configuration de la connexion SSH Serveur/client
 

1. Installation de SSH  
 
L'installation de SSH (Secure Shell) permet d'établir une connexion sécurisée entre un serveur et un client. Cette connexion chiffrée garantit la confidentialité et l'intégrité des données échangées.

#### Sur le serveur :

```bash
sudo apt-get install openssh-server
```
#### Sur le client :

```bash
sudo apt-get install openssh-client
```
2. Génération de clés SSH sur le serveur    

Générez une paire de clés SSH sur le serveur pour une authentification sécurisée.
La génération d'une paire de clés SSH (clé privée et clé publique) renforce la sécurité de la connexion SSH en utilisant une méthode d'authentification par clé publique plutôt qu'un simple mot de passe.

```bash
ssh-keygen -t rsa -b 4096 -C "commentaire"
```

3. Mise en place d'un agent SSH sur le serveur  

L'agent SSH permet de gérer les clés privées et d'éviter de saisir la phrase secrète de la clé privée à chaque utilisation. Il stocke les clés en mémoire et les utilise pour authentifier les connexions SSH.  


```bash
eval $(ssh-agent -s)
```
4. Ajout de la clé privée à l'agent sur le serveur  

```bash
ssh-add ~/.ssh/id_rsa
```
5. Vérification de l'ajout de la clé sur le serveur  

```bash
ssh-add -l
```
6. Copie de la clé publique sur le PC client  

```bash
ssh-copy-id utilisateur@adresse_ip_du_client
```
7. Connexion en SSH depuis le serveur vers le client  

Cette commande initie une connexion SSH sécurisée depuis le serveur vers le client, utilisant la clé publique pour l'authentification. Si les étapes précédentes ont été correctement effectuées, aucune saisie de mot de passe ne sera nécessaire.

```bash
ssh utilisateur@adresse_ip_du_client
```
8. Vérification des Pare-feux  

Ces commandes configurent le pare-feu UFW pour autoriser les connexions entrantes(serveur) et sortantes(client) sur le port SSH (par défaut, le port 22) et activent le pare-feu pour appliquer les règles.      

Sur le serveur Debian :

```bash
sudo ufw allow ssh
sudo ufw enable
```
Sur le poste client Linux :

```bash
sudo ufw allow out ssh
sudo ufw enable
```
9. Automatisation de l'Agent SSH    

Pour éviter d'initialiser l'agent SSH et d'ajouter la clé à chaque nouvelle session, on a automatisé ces étapes.

Edition du fichier de configuration du shell :

```bash
nano ~/.bashrc
```
Ajout des lignes suivantes à la fin du fichier :

```bash
# Initialiser l'agent SSH
eval $(ssh-agent -s)

# Ajouter la clé privée à l'agent SSH
ssh-add ~/.ssh/id_rsa
```
Recharge du fichier de configuration du shell :  
```
source ~/.bashrc
```


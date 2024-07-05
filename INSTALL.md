#### Prérequis : 

- Client Ubuntu 22.04 LTS :
- Nom : CLILIN01
- Compte utilisateur : wilder (dans le groupe sudo)
- Mot de passe : Azerty1*
- Adresse IP fixe : 172.16.10.30/24

- Serveur Debian 12 :
- Nom : SRVLX01
- Compte : root
- Mot de passe : Azerty1*
- Adresse IP fixe : 172.16.10.10/24

# Changer l'adresse IP sur Debian 

## Prérequis techniques

- Accès à un terminal sur la machine Debian
- Privilèges administratifs (accès root ou sudo)
- Nom de l'interface réseau : `ens18` *(selon le nom de votre interface réseau)*
- Adresse IP fixe souhaitée : `192.168.1.x` *(x c'est le nombre que vous voulez pour l'adresse IP)*
- Masque de sous-réseau : `255.255.255.0`
- Passerelle : `192.168.1.254`
- Serveurs DNS : `192.168.1.254`

## Étapes d'installation et de configuration

### 1. Ouvrir une session avec des privilèges administratifs

Ouvrez un terminal et passez en mode superutilisateur ou utilisez sudo pour chaque commande.

2. Identifier le nom de l'interface réseau
Vérifiez le nom de l'interface réseau (ici, nous supposons que c'est ens18 ).
`ip a`

Le nom de votre interface réseau (surligné en jaune) :

![Choix de l'adaptateur](Images/Choix_IP_Fixe_Debian1.png)

4. Modifier le fichier de configuration réseau
Éditez le fichier /etc/network/interfaces.
`nano /etc/network/interfaces`

Ajoutez ou modifiez les lignes suivantes pour configurer votre interface réseau (ens18 dans cet ex)  avec une adresse IP fixe.

- auto ens18
- iface ens18 inet static
- address 192.168.1.x
- netmask 255.255.255.0
- gateway 192.168.1.254
- dns-nameservers 192.168.1.254

4. Enregistrer et fermer le fichier
Pour enregistrer et fermer le fichier dans nano :

*Appuyez sur Ctrl + O puis Enter pour enregistrer.
Appuyez sur Ctrl + X pour quitter l'éditeur.*

5. Redémarrer le service réseau
Redémarrez le service réseau pour appliquer les modifications.
`systemctl restart networking`
6. Vérifier la nouvelle configuration IP
Vérifiez que l'adresse IP a été mise à jour correctement.
`ip a`

![Choix de l'adaptateur](Images/Choix_IP_Fixe_Debian2.png)

# Changer l'adresse IP sur Ubuntu

### Ouvrir le fichier de configuration Netplan :

- Le fichier de configuration Netplan se trouve généralement dans le répertoire /etc/netplan/.
- Listez les fichiers dans ce répertoire pour identifier le fichier de configuration :

```ls /etc/netplan/```

### Ouvrez le fichier de configuration (par exemple, 01-netcfg.yaml) avec un éditeur de texte :

```sudo nano /etc/netplan/01-netcfg.yaml```

#### Modifier les paramètres réseau :

- Localisez la section ethernets et modifiez-la pour définir une adresse IP statique. Voici un exemple de configuration :

`
yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses: [192.168.1.100/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
`

- Remplacez `eth0` ar le nom de votre interface réseau (vous pouvez trouver le nom de l'interface en utilisant la commande `ip a`).
- Remplacez `192.168.1.100/24` par l'adresse IP et le masque de sous-réseau que vous souhaitez utiliser.
- Remplacez `192.168.1.1` par l'adresse IP de la passerelle (gateway).
- Remplacez `8.8.8.8`, `8.8.4.4` par les adresses IP des serveurs DNS que vous souhaitez utiliser.
- Appliquer les modifications :

`sudo netplan apply`

Vérification
Vérifier la nouvelle adresse IP :

`ip a`

- Assurez-vous que l'adresse IP a été correctement modifiée.


## Installation d'OpenSSH sur le Serveur Debian

### Étape 1 : Mise à jour du Système

- Mettre à jour la liste des paquets et les paquets installés :

`sudo apt update
sudo apt upgrade`

### Étape 2 : Installation d'OpenSSH Server

- Installer OpenSSH Server :

`sudo apt install openssh-server`

- Vérifier que le service SSH est actif :

`sudo systemctl status ssh`

- Démarrer et activer le service SSH :

`sudo systemctl start ssh
sudo systemctl enable ssh`

### Configuration du Serveur SSH :

- Configurer les paramètres du serveur SSH en éditant le fichier de configuration

`sudo nano /etc/ssh/sshd_config`

Quelques paramètres importants que vous pouvez configurer :

`PermitRootLogin no
PasswordAuthentication yes`

Redémarrer le service SSH pour appliquer les modifications :

`sudo systemctl restart ssh`

## Installation sur le Client Ubuntu

### Étape 1 : Mise à jour du Système

- Mettre à jour la liste des paquets et les paquets installés :

`sudo apt update
sudo apt upgrade`


### Étape 2 : Installation d'OpenSSH Client

- Installer OpenSSH Client :

`sudo apt install openssh-client`

Vérification de la Connexion SSH
Trouver l'adresse IP du serveur Debian :

Sur le serveur Debian, exécutez :

`hostname -I`

- Se connecter au serveur Debian depuis le client Ubuntu :

- Sur le client Ubuntu, ouvrez un terminal et exécutez :

`ssh username@ip_address_of_debian_server`

Remplacez `username` par votre nom d'utilisateur sur le serveur Debian.
Remplacez `ip_address_of_debian_server` par l'adresse IP obtenue.

- Accepter l'empreinte numérique de la clé du serveur la première fois :

- Vous verrez un message similaire à :

`The authenticity of host 'ip_address_of_debian_server (ip_address_of_debian_server)' can't be established.
ECDSA key fingerprint is SHA256:...
Are you sure you want to continue connecting (yes/no)?`

- Tapez `yes` et appuyez sur Entrée.

- Entrer le mot de passe pour username sur le serveur Debian.






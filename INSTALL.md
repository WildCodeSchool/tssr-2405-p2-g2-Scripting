# Changer l'adresse IP sur Debian et Ubuntu Linux

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

## 3. VM Ubuntu Client 22.04 LTS

#### Prérequis : 
- Client Ubuntu 22.04 LTS :
- Nom : CLILIN01
- Compte utilisateur : wilder (dans le groupe sudo)
- Mot de passe : Azerty1*
- Adresse IP fixe : 172.16.10.30/24

#### Configuration obligatoire :
**A. Installation SSH**

 - Exécuter le Terminal

```bash
sudo apt-get install openssh-server
```

![UBUNTU](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/Images%20Greg/install%20ssh%20Ubuntu%201.PNG)

Lors du message : **`Souhaitez-vous continuer ? [O/n]`**-> Taper **`O`**


- Une fois le SSH installé, il faut l'activer :
```bash
 sudo systemctl enable ssh
```

![active](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/Images%20Greg/activation%20ssh%20ubuntu.PNG)


**B. Installation des paquets nécessaires** 

- Exécuter le Terminal

- Pour installer le paquet de la commande ifconfig faire :
  ```bash
  sudo apt install net-tools
  ```

  ![](https://www.cjoint.com/doc/24_04/NDro5ObmV1n_IFconfig.png)

- Pour installer le paquet de la commande
  ```bash
  sudo apt install sysstat
  ```
  ![](https://www.cjoint.com/doc/24_04/NDrpmkMXM2n_Bash-proceseru.png)




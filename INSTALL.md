# Changer l'adresse IP sur Debian Linux

## Prérequis techniques

- Accès à un terminal sur la machine Debian
- Privilèges administratifs (accès root ou sudo)
- Nom de l'interface réseau : `eth0` *(selon le nom de votre interface réseau)*
- Adresse IP fixe souhaitée : `192.168.1.x` *(x c'est le nombre que vous voulez pour l'adresse IP)*
- Masque de sous-réseau : `255.255.255.0`
- Passerelle : `192.168.1.254`
- Serveurs DNS : `192.168.1.254`

## Étapes d'installation et de configuration

### 1. Ouvrir une session avec des privilèges administratifs

Ouvrez un terminal et passez en mode superutilisateur ou utilisez sudo pour chaque commande.

2. Identifier le nom de l'interface réseau
Vérifiez le nom de l'interface réseau (ici, nous supposons que c'est eth0).
`ip a`

`1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: **eth0** : <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:3e:5e:6a brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.46/24 brd 192.168.1.255 scope global dynamic eth0
       valid_lft 600sec preferred_lft 600sec
    inet6 fe80::20c:29ff:fe3e:5e6a/64 scope link
       valid_lft forever preferred_lft forever`

4. Modifier le fichier de configuration réseau
Éditez le fichier /etc/network/interfaces.
`nano /etc/network/interfaces`

Ajoutez ou modifiez les lignes suivantes pour configurer l'interface réseau ens18 avec une adresse IP fixe.

`auto ens18
iface ens18 inet static
    address 192.168.1.x
    netmask 255.255.255.0
    gateway 192.168.1.254
    dns-nameservers 192.168.1.254`

4. Enregistrer et fermer le fichier
Pour enregistrer et fermer le fichier dans nano :

Appuyez sur Ctrl + O puis Enter pour enregistrer.
Appuyez sur Ctrl + X pour quitter l'éditeur.

5. Redémarrer le service réseau
Redémarrez le service réseau pour appliquer les modifications.
`systemctl restart networking`

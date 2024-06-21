# **Permettre les actions depuis le serveur sur les postes clients**

## **Activer PowerShell Remoting**
_Sur le poste client_
Ouvrir une session PowerShell en tant qu'administrateur et exécuter la commande suivante :
```Enable-PSRemoting -Force```


_Sur le serveur_
Ouvrir une session PowerShell en tant qu'administrateur et exécuter la commande suivante :
```Enable-PSRemoting -Force```

Cela permettra d'activer le PSRemoting sur les deux machines. Une fois PSRemoting activé, il le reste tant que l'on ne l'interrompt pas manuellement.


## **Configurer la confiance entre les machines**
Il faut ajouter les différentes machines aux hôtes de confiance. Il faudra sur le client et sur le serveur rentrer la commande suivante :

```Set-Item wsman:\localhost\Client\TrustedHosts -Value "NomMachine"```

Il faudra remplacer "NomMachine" par l'adresse IP du serveur sur le client et l'adresse IP du client sur le serveur.

Pour tester la connexion entre les machines, on peut utiliser la commande :
```Test-WsMan -ComputerName NomMachine```

S'il est concluant, on obtient :

![Testconnexion](https://github.com/WildCodeSchool/tssr-2405-p2-g2-Scripting/blob/Nicolas/Screen%20PSR/01.Testconnexionpsr.png?raw=true)

La connnexion entre les machines est effective, mais on ne peut toutefois pas encore exécuter de commandes à distance, il faut pour cela créer un compte-administrateur sur le client et configurer son Pare-Feu.

## **Configuration du Pare-Feu**
Sur le poste client, il faudra créer une règle de Pare-feu qui autorise les connexions WinRM. Le port par défaut pour WinRM sur HTTP est **5985**, en HTTPS ce sera le port **5986**
Il faudra employer les commandes suivantes :
Sur HTTP :
```New-NetFirewallRule -Name "AllowWinRM" -DisplayName "Allow WinRM" -Protocol TCP -LocalPort 5985 -Action Allow``` 

Sur HTTPS :
```New-NetFirewallRule - Name "AllowWin-HTTPS" -DisplayName "Allow WinRM (HTTPS)" -Protocol TCP -LocalPort 5986 -Action Allow ```

## **Installation du compte administrateur local**
Sur la machine client, ouvrir PowerShell en tant qu'admin et créer l'utilisateur avec la commande suivante, en remplaçant "NomAdmin" par le nom que l'on souhaite donner au compte administrateur et "Mdp" par le mot de passe que l'on souhaite y attribuer.

```net user NomAdmin Mdp /add```

Il faudra ensuite ajouter le nouveau compte au groupe Administrateurs :

```net localgroup Administrateurs "NomAdmin" /add```

Désormais, on peut effectuer des commandes à distance depuis le serveur, il faudra renseigner le nom d'utilisateur et le mot de passe à chaque fois.

## **Automatisation des logs**
Pour ne pas avoir à rentrer les identifiants à chaque nouvelle commande effectuée sur le poste distant, on peut stocker les informations d'identification dans un fichier sécurisé. Notez que ces informations devront être les mêmes pour les comptes administrateurs de tous les postes clients.

```
$NomUtilisateur = admin
$MotDePasse = Read-Host -AsSecureString Azerty1*
$Cred = New-Object System.Management.Automation.PSCredential($NomUtilisateur, $MotDePasse)
$Cred | Export-Clixml -Path "C:\chemin\vers\cred.xml"
```

Pour Exécuter les commandes à distances, il faudra inclure dans les scripts 

```
$Cred = Import-Clixml -Path "C:\Users\Administrator\pclients\cred.xml"
Invoke-Command -ComputerName IPduposteclient -Credential $Cred -ScriptBlock {scriptàlancer}
```

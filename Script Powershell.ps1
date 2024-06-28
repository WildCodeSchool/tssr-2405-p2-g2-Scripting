# Fonction pour afficher le menu principal
function Show-MainMenu {
    Clear-Host
    Write-Host "Menu Principal"
    Write-Host "1. Utilisateur"
    Write-Host "2. Ordinateur"
    Write-Host "3. Quitter"
    return (Read-Host "Choisissez une option (1-3)")
}

# Fonction pour afficher le menu des actions utilisateur
function Show-UserMenu {
    Clear-Host
    Write-Host "Actions Utilisateur"
    Write-Host "1. Creer un compte utilisateur"
    Write-Host "2. Supprimer un compte utilisateur"
    Write-Host "3. Obtenir la date de dernière connexion"
    Write-Host "4. Retour"
    return (Read-Host "Choisissez une option (1-4)")
}

# Fonction pour afficher le menu des actions ordinateur
function Show-ComputerMenu {
    Clear-Host
    Write-Host "Actions Ordinateur"
    Write-Host "1. Arrêter l'ordinateur"
    Write-Host "2. Redémarrer l'ordinateur"
    Write-Host "3. Obtenir la version de l'OS"
    Write-Host "4. Retour"
    return (Read-Host "Choisissez une option (1-4)")
}

# Fonction pour créer un compte utilisateur
function New-UserAccount {
    param (
        [string]$NomUtilisateur
    )
    try {
        New-LocalUser -Name $NomUtilisateur -Description "Compte créé via script PowerShell" -NoPassword
        Write-Host "Utilisateur $NomUtilisateur créé avec succès."
    } catch {
        Write-Host "Erreur lors de la création de l'utilisateur $NomUtilisateur : $_"
    }
}

# Fonction pour supprimer un compte utilisateur
function Remove-UserAccount {
    param (
        [string]$NomUtilisateur
    )
    try {
        Remove-LocalUser -Name $NomUtilisateur -ErrorAction Stop
        Write-Host "Utilisateur $NomUtilisateur supprimé avec succès."
    } catch {
        Write-Host "Erreur lors de la suppression de l'utilisateur $NomUtilisateur : $_"
    }
}

# Fonction pour obtenir la date de dernière connexion d'un utilisateur
function Get-LastLogonDate {
    param (
        [string]$NomUtilisateur
    )
    try {
        $lastLogon = Get-WinEvent -LogName "Security" | Where-Object {
            $_.Id -eq 4624 -and $_.Properties[5].Value -eq $NomUtilisateur
        } | Select-Object -First 1 -Property TimeCreated

        if ($lastLogon) {
            $dateDerniereConnexion = $lastLogon.TimeCreated
            Write-Host "Date de dernière connexion de l'utilisateur $NomUtilisateur : $dateDerniereConnexion"
            return $dateDerniereConnexion
        } else {
            Write-Host "Aucune connexion trouvée pour l'utilisateur $NomUtilisateur."
            return $null
        }
    } catch {
        Write-Host "Erreur lors de l'obtention de la dernière connexion de l'utilisateur $NomUtilisateur : $_"
        return $null
    }
}

# Fonction pour arrêter un ordinateur
function Stop-ComputerAction {
    param (
        [string]$NomOrdinateur
    )
    try {
        Stop-Computer -ComputerName $NomOrdinateur -Force
        Write-Host "Ordinateur $NomOrdinateur arrêté avec succès."
    } catch {
        Write-Host "Erreur lors de l'arrêt de l'ordinateur $NomOrdinateur : $_"
    }
}

# Fonction pour redémarrer un ordinateur
function Restart-ComputerAction {
    param (
        [string]$NomOrdinateur
    )
    try {
        Restart-Computer -ComputerName $NomOrdinateur -Force
        Write-Host "Ordinateur $NomOrdinateur redémarré avec succès."
    } catch {
        Write-Host "Erreur lors du redémarrage de l'ordinateur $NomOrdinateur : $_"
    }
}

# Fonction pour obtenir la version du système d'exploitation d'un ordinateur
function Get-ComputerOSInfo {
    param (
        [string]$NomOrdinateur
    )

    try {
        $osInfo = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $NomOrdinateur

        if ($osInfo) {
            $osName = $osInfo.Caption
            $osVersion = $osInfo.Version
            return "$osName (Version: $osVersion)"
        } else {
            Write-Host "Impossible de récupérer les informations sur l'OS de l'ordinateur $NomOrdinateur."
            return $null
        }
    } catch {
        Write-Host "Erreur lors de la récupération des informations sur l'OS de l'ordinateur $NomOrdinateur : $_"
        return $null
    }
}

# Fonction pour enregistrer une action dans le journal log_evt.log
function Write-Information {
    param (
        [string]$Cible,
        [string]$Informations
    )
    $date = Get-Date -Format "yyyyMMdd"
    $nomFichier = "info_${Cible}_${date}.txt"
    $cheminFichier = Join-Path $env:USERPROFILE\Documents $nomFichier

    try {
        Set-Content -Path $cheminFichier -Value $Informations -Force
        Write-Host "Informations enregistrées avec succès dans $cheminFichier"
    } catch {
        Write-Host "Erreur lors de l'enregistrement des informations : $_"
    }
}

# Fonction pour gérer l'enregistrement d'une action
function Write-Action {
    param (
        [string]$Cible,
        [string]$Action,
        [string]$Information
    )

    # Demander si l'utilisateur souhaite enregistrer l'action
    $choixEnregistrement = Read-Host "Voulez-vous enregistrer cette action ? (Oui/Non)"
    if ($choixEnregistrement -eq "Oui") {
        Write-Information -Cible $Cible -Informations "$Action : $Information"
    }
}

# Boucle principale du script
while ($true) {
    $choixPrincipal = Show-MainMenu

    switch ($choixPrincipal) {
        1 {
            while ($true) {
                $choixActionUtilisateur = Show-UserMenu

                if ($choixActionUtilisateur -eq "4") {
                    break
                }

                switch ($choixActionUtilisateur) {
                    1 {
                        $nomUtilisateur = Read-Host "Entrez le nom du compte utilisateur à créer"
                        New-UserAccount -NomUtilisateur $nomUtilisateur
                        Write-Action -Cible "Utilisateur" -Action "Création du compte utilisateur" -Information $nomUtilisateur
                    }
                    2 {
                        $nomUtilisateur = Read-Host "Entrez le nom du compte utilisateur à supprimer"
                        Remove-UserAccount -NomUtilisateur $nomUtilisateur
                        Write-Action -Cible "Utilisateur" -Action "Suppression du compte utilisateur" -Information $nomUtilisateur
                    }
                    3 {
                        $nomUtilisateur = Read-Host "Entrez le nom du compte utilisateur pour obtenir la date de dernière connexion"
                        $dateDerniereConnexion = Get-LastLogonDate -NomUtilisateur $nomUtilisateur
                        if ($dateDerniereConnexion) {
                            Write-Action -Cible "Utilisateur" -Action "Dernière connexion de l'utilisateur" -Information "$nomUtilisateur : $dateDerniereConnexion"
                        }
                    }
                    default { Write-Host "Choix invalide. Veuillez reessayer." }
                }
            }
        }
        2 {
            while ($true) {
                $choixActionOrdinateur = Show-ComputerMenu

                if ($choixActionOrdinateur -eq "4") {
                    break
                }

                switch ($choixActionOrdinateur) {
                    1 {
                        $nomOuIP = Read-Host "Entrez le nom ou l'adresse IP de l'ordinateur à arrêter"
                        Stop-ComputerAction -NomOrdinateur $nomOuIP
                        Write-Action -Cible "Ordinateur" -Action "Arrêt de l'ordinateur" -Information $nomOuIP
                    }
                    2 {
                        $nomOuIP = Read-Host "Entrez le nom ou l'adresse IP de l'ordinateur à redémarrer"
                        Restart-ComputerAction -NomOrdinateur $nomOuIP
                        Write-Action -Cible "Ordinateur" -Action "Redémarrage de l'ordinateur" -Information $nomOuIP
                    }
                    3 {
                        $nomOuIP = Read-Host "Entrez le nom ou l'adresse IP de l'ordinateur pour obtenir la version de l'OS"
                        $versionOS = Get-ComputerOSInfo -NomOrdinateur $nomOuIP
                        if ($versionOS) {
                            Write-Action -Cible "Ordinateur" -Action "Version de l'OS de l'ordinateur" -Information "$nomOuIP : $versionOS"
                        }
                    }
                    default { Write-Host "Choix invalide. Veuillez réessayer." }
                }
            }
        }
        3 { 
            Write-Host "Au revoir!"
            exit 
        }
        default { Write-Host "Choix invalide. Veuillez réessayer." }
    }
}

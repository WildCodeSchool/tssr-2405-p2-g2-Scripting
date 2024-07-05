#!/bin/bash

#####################################################
# Script de Gestion d'Administration pour WCS
#
# Ce script permet de gérer à distance des utilisateurs
# et des ordinateurs via SSH. Assurez-vous d'avoir
# une connexion SSH préétablie et les privilèges requis.
#
# Auteurs: TSSR GROUPE 2
# Date: 5 juillet 2024
#####################################################

# Variables globales pour les fichiers de journalisation et d'informations
log_file="/var/log/log_evt.log"
info_dir="/home/wilder/Documents"

# Fonction pour journaliser les activités
log_event() {
    local event_message="$1"
    local timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "$timestamp - $(whoami) - $event_message" >> "$log_file"
}

# Fonction pour enregistrer les informations de la cible
save_info() {
    local target="$1"
    local info_type="$2"
    local info_data="$3"
    local info_file="$info_dir/info_${target}_$(date '+%Y-%m-%d').txt"
    echo "$info_data" > "$info_file"
    echo "Informations sur $info_type enregistrées dans $info_file"
}

# Fonction pour démarrer le script avec une entrée de journalisation
start_script() {
    log_event "********StartScript********"
}

# Fonction pour terminer le script avec une entrée de journalisation
end_script() {
    log_event "*********EndScript*********"
}

# Demander les informations de connexion
read -p "Nom d'utilisateur sur la machine distante: " remote_user
read -p "Adresse IP de la machine distante: " remote_ip

log_event "Connexion à la machine distante avec l'utilisateur $remote_user à l'adresse $remote_ip"

# Fonction pour afficher le menu principal
main_menu() {
    clear
    echo -e "\e[1;31m=====================================\e[0m"
    echo -e "\e[1;31m Welcome to the MAIN MENU OF THE WCS\e[0m"
    echo -e "\e[1;31m=====================================\e[0m"
    echo -e "\e[1;36m1. \e[0m\e[1;32mGestion des utilisateurs\e[0m"
    echo -e "\e[1;36m2. \e[0m\e[1;32mGestion des ordinateurs\e[0m"
    echo -e "\e[1;36m3. \e[0m\e[1;32mQuitter\e[0m"
    echo -e "\e[1;31m-------------------------------------\e[0m"
    read -p "Sélectionnez une option: " main_choice
    case $main_choice in
        1) log_event "Accès au menu Gestion des Utilisateurs"; user_menu ;;
        2) log_event "Accès au menu Gestion des Ordinateurs"; computer_menu ;;
        3) log_event "Sortie du script"; end_script; exit 0 ;;
        *) echo -e "\e[1;31mOption invalide\e[0m"; log_event "Option invalide sélectionnée dans le menu principal"; main_menu ;;
    esac
}

# Fonction pour afficher le menu des utilisateurs
user_menu() {
    clear
    echo -e "\e[1;34m==================================\e[0m"
    echo -e "\e[1;34m   Menu Gestion des Utilisateurs\e[0m"
    echo -e "\e[1;34m==================================\e[0m"
    echo -e "\e[1;36m1. \e[0m\e[1;32mCréer un compte\e[0m"
    echo -e "\e[1;36m2. \e[0m\e[1;32mSupprimer un compte\e[0m"
    echo -e "\e[1;36m3. \e[0m\e[1;32mInformations sur un utilisateur\e[0m"
    echo -e "\e[1;36m4. \e[0m\e[1;32mRetour\e[0m"
    echo -e "\e[1;34m----------------------------------\e[0m"
    read -p "Sélectionnez une option: " user_choice
    case $user_choice in
        1) log_event "Sélection de la création d'un compte utilisateur"; create_account ;;
        2) log_event "Sélection de la suppression d'un compte utilisateur"; delete_account ;;
        3) log_event "Demande d'informations sur un utilisateur"; user_info ;;
        4) log_event "Retour au menu principal depuis le menu utilisateurs"; main_menu ;;
        *) echo -e "\e[1;31mOption invalide\e[0m"; log_event "Option invalide sélectionnée dans le menu utilisateurs"; user_menu ;;
    esac
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
}

# Fonction pour afficher le menu des ordinateurs
computer_menu() {
    clear
    echo -e "\e[1;33m==================================\e[0m"
    echo -e "\e[1;33m   Menu Gestion des Ordinateurs\e[0m"
    echo -e "\e[1;33m==================================\e[0m"
    echo -e "\e[1;36m1. \e[0m\e[1;32mArrêter\e[0m"
    echo -e "\e[1;36m2. \e[0m\e[1;32mRedémarrer\e[0m"
    echo -e "\e[1;36m3. \e[0m\e[1;32mInformations sur un ordinateur\e[0m"
    echo -e "\e[1;36m4. \e[0m\e[1;32mRetour\e[0m"
    echo -e "\e[1;33m----------------------------------\e[0m"
    read -p "Sélectionnez une option: " computer_choice
    case $computer_choice in
        1) log_event "Sélection de l'arrêt de la machine distante"; shutdown_remote ;;
        2) log_event "Sélection du redémarrage de la machine distante"; reboot_remote ;;
        3) log_event "Demande d'informations sur un ordinateur"; computer_info ;;
        4) log_event "Retour au menu principal depuis le menu ordinateurs"; main_menu ;;
        *) echo -e "\e[1;31mOption invalide\e[0m"; log_event "Option invalide sélectionnée dans le menu ordinateurs"; computer_menu ;;
    esac
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
}

# Fonction pour créer un compte utilisateur
create_account() {
    read -p "Nom d'utilisateur à créer: " username
    ssh $remote_user@$remote_ip "sudo useradd $username"
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mCompte utilisateur '$username' créé sur $remote_ip\e[0m"
        log_event "Compte utilisateur '$username' créé sur $remote_ip"
        save_info "$username" "creation" "Nom d'utilisateur: $username Créé par: $remote_user Sur la machine: $remote_ip"
    else
        echo -e "\e[1;31mErreur lors de la création du compte utilisateur '$username' sur $remote_ip\e[0m"
        log_event "Erreur lors de la création du compte utilisateur '$username' sur $remote_ip"
    fi
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
    user_menu
}

# Fonction pour supprimer un compte utilisateur
delete_account() {
    read -p "Nom d'utilisateur à supprimer: " username
    ssh $remote_user@$remote_ip "sudo userdel $username"
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mCompte utilisateur '$username' supprimé sur $remote_ip\e[0m"
        log_event "Compte utilisateur '$username' supprimé sur $remote_ip"
        save_info "$username" "suppression" "Nom d'utilisateur: $username Supprimé par: $remote_user Sur la machine: $remote_ip"
    else
        echo -e "\e[1;31mErreur lors de la suppression du compte utilisateur '$username' sur $remote_ip\e[0m"
        log_event "Erreur lors de la suppression du compte utilisateur '$username' sur $remote_ip"
    fi
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
    user_menu
}

# Fonction pour obtenir des informations sur un utilisateur
user_info() {
    read -p "Nom d'utilisateur à vérifier: " username
    info=$(ssh $remote_user@$remote_ip "lastlog -u $username 2>&1")
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mDernière connexion de l'utilisateur '$username':\e[0m"
        echo "$info"
        log_event "Informations récupérées pour l'utilisateur '$username'"
        save_info "$username" "last_login" "$info"
    else
        echo -e "\e[1;31mErreur lors de la récupération des informations pour l'utilisateur '$username'.\e[0m"
        echo -e "\e[1;31mMessage d'erreur: $info\e[0m"
        log_event "Erreur lors de la récupération des informations pour l'utilisateur '$username'. Message d'erreur: $info"
    fi
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
    user_menu
}

# Fonction pour obtenir des informations sur un ordinateur
computer_info() {
    read -p "Nom de l'ordinateur à vérifier: " computername
    info=$(ssh $remote_user@$remote_ip "uname -a 2>&1")
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mInformations sur l'ordinateur '$computername':\e[0m"
        echo "$info"
        log_event "Informations récupérées pour l'ordinateur '$computername'"
        save_info "$computername" "system_info" "$info"
    else
        echo -e "\e[1;31mErreur lors de la récupération des informations pour l'ordinateur '$computername'.\e[0m"
        echo -e "\e[1;31mMessage d'erreur: $info\e[0m"
        log_event "Erreur lors de la récupération des informations pour l'ordinateur '$computername'. Message d'erreur: $info"
    fi
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
    computer_menu
}

# Fonction pour arrêter la machine distante
shutdown_remote() {
    ssh $remote_user@$remote_ip "sudo shutdown -h now"
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mMachine $remote_ip arrêtée\e[0m"
        log_event "Machine $remote_ip arrêtée"
        save_info "$remote_ip" "shutdown" "Arrêt de la machine Par: $remote_user Adresse IP: $remote_ip"
    else
        echo -e "\e[1;31mErreur lors de l'arrêt de la machine $remote_ip\e[0m"
        log_event "Erreur lors de l'arrêt de la machine $remote_ip"
    fi
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
    computer_menu
}

# Fonction pour redémarrer la machine distante
reboot_remote() {
    ssh $remote_user@$remote_ip "sudo reboot"
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mMachine $remote_ip redémarrée\e[0m"
        log_event "Machine $remote_ip redémarrée"
        save_info "$remote_ip" "reboot" "Redémarrage de la machine Par: $remote_user Adresse IP: $remote_ip"
    else
        echo -e "\e[1;31mErreur lors du redémarrage de la machine $remote_ip\e[0m"
        log_event "Erreur lors du redémarrage de la machine $remote_ip"
    fi
    echo -e "\e[1;32mAppuyez sur Entrée pour continuer...\e[0m"
    read -s -n 1 -p ""
    computer_menu
}

# Créer le répertoire d'informations s'il n'existe pas
mkdir -p "$info_dir"

# Démarrer le script
start_script

# Afficher le menu principal
main_menu

# Projet de Gestion de Tâches à Distance via Script

## Introduction : Mise en Contexte

Ce projet a pour objectif de créer un script qui s’exécute sur une machine locale et qui effectue des tâches sur des machines distantes, toutes connectées sur le même réseau. Les tâches peuvent inclure des actions pour l'utilisateur telles que : 
- La création, suppression de compte et des demandes d'informations comme la date de la derniére connexion.
  
Pour l'ordinateur :  

- Arrêt, redémarrage de la machine ou des requêtes d’information comme la version de l'OS.
   
Ce projet est mené par une équipe de 5 personnes en formation TSSR.

## Objectifs principaux et secondaires

Objectifs principaux :

- Mettre en place une architecture client/serveur
- Depuis une machine Windows Server, on exécute un script PowerShell qui cible des ordinateurs Windows
- Depuis une machine Debian, on exécute un script shell qui cible des ordinateurs Ubuntu
- Réaliser un projet en équipe
- Documenter toutes les étapes
- Faire une démonstration de la réalisation finale

Objectif secondaire :
Depuis un serveur, cibler une machine cliente avec un type d’OS différent.


## Membres du Groupe de Projet et Rôles par Sprint


| **Sprint**                                  | **Product Owner (PO)** | **Scrum Master (SM)** | **Développeurs**        | **Objectifs**                                                                                                                                                                              |
|---------------------------------------------|------------------------|-----------------------|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Sprint 1 : Mise en place de l'environnement**  | Ronan                  | Nicolas               | Mehdi, Julie, Mohamed   | - Configurations des outils nécessaires (Jira, Git, Proxmox).<br> - Configuration des environnements de développement et de test.<br> - Établissement des connexions réseau entre les machines locales et distantes. |
| **Sprint 2 : Développement des premiers scripts** | Nicolas                | Mehdi                 | Julie, Mohamed, Ronan   | - Développement des scripts de base pour les actions utilisateur .<br> - Mise en place des scripts pour les demandes d'informations .<br> - Réalisation des tests unitaires pour les scripts développés. |
| **Sprint 3 : Extension des fonctionnalités**     | Mehdi                  | Julie                 | Mohamed, Ronan, Nicolas | - Ajout des fonctionnalités pour les actions sur les machines .<br> - Développement des requêtes d'information sur les machines .<br> - Intégration des nouvelles fonctionnalités avec les scripts existants. |
| **Sprint 4 : Sécurisation et robustesse**        | Julie                  | Mohamed               | Ronan, Nicolas, Mehdi   | - Mise en place des mesures de sécurité (authentification, autorisation).<br> - Renforcement de la robustesse des scripts (gestion des erreurs, logs).<br> - Réalisation de tests de sécurité et de robustesse. |
| **Sprint 5 : Tests finaux et déploiement**       | Mohamed                | Ronan                 | Nicolas, Mehdi, Julie   | - Exécution des tests finaux (fonctionnels, de performance).<br> - Préparation de la documentation utilisateur et technique.<br> - Déploiement du script sur les machines locales et vérification de son bon fonctionnement. |


## Choix Techniques

### Les Serveurs

| **Système**       | **Debian 12.5**  | **Windows Server 2022**  |
|-------------------|------------------|--------------------------|
| **HostName**      | SRVLX01          | SRVWIN01                 |
| **Login**         | root             | administrator            |
| **Password**      | Azerty1*         | Azerty1*                 |
| **IP Fixe**       | 172.16.10.46/24  | 172.16.10.40/24           |
| **Spécificité**   | Bash shell 5.2.21             | Powershell Core 7.4 LTS inclus |

### Les Clients

| **Système**          | **Ubuntu 22.04 LTS 01** | **Windows 10** | 
|----------------------|-------------------------|-------------------------|
| **HostName**         | CLILIN01                | CLIWIN01                | 
| **Login**            | wilder                  | wilder                  | 
| **Password**         | Azerty1*                | Azerty1*                | 
| **IP Fixe**          | 172.16.10.45/24         | 172.16.10.43/24         |

 
  
- **Langages de script** : Powershell/Bash
- **Outils de gestion de projet** : Jira
- **Contrôle de version** : Git
- **Outils de communication** : Discord/GoogleMeet


## Difficultés Rencontrées

### Problèmes Techniques Rencontrés
- Mise en réseau des VM clients et serveurs, ping possible depuis les serveurs mais pas depuis les postes clients.
- Exécution de scripts PowerShell sur des machines cibles Windows avec des permissions limitées.
- Difficultés dans l'authentification et l'autorisation des scripts shell sur les machines cibles Ubuntu.

### Problèmes de Communication
- Synchronisation des tâches entre les membres de l'équipe.
- Partage de la documentation et des mises à jour de l'état du projet.
- Coordination des réunions et des points de suivi réguliers.

## Solutions Trouvées

### Solutions et Alternatives
- **Réseau** : Configuration des IP fixes pour chaque VM et des pare-feu sur les postes clients pour autoriser les requêtes ICMP entrantes, test de connectivité via la commande PING.
- **Scripts PowerShell** : Utilisation de comptes administratifs locaux avec les permissions nécessaires pour l'exécution des scripts PowerShell. Implémentation de la signature des scripts pour éviter les restrictions d'exécution.
- **Scripts Shell** : Mise en place de clés SSH pour l'authentification sans mot de passe et ajout des utilisateurs appropriés dans le fichier `sudoers` pour permettre l'exécution des scripts avec les permissions nécessaires.
- **Communication** : Utilisation d'outils de gestion de projet comme Jira pour suivre les tâches et les progrès. Organisation de réunions ponctuelles via Discord pour synchroniser l'équipe et résoudre les problèmes rapidement. Partage de la documentation via Google Drive et Github pour assurer l'accès à jour pour tous les membres de l'équipe.

## Améliorations Possibles

### Suggestions d’Améliorations Futures

- **Automatisation des Déploiements** : Mettre en place des outils d'automatisation (comme Ansible ou Puppet) pour déployer et configurer les scripts sur les machines cibles de manière plus efficace.
- **Tests de Compatibilité Cross-OS** : Travailler sur l'objectif secondaire de cibler des machines clientes avec des types d’OS différents (par exemple, exécuter des scripts PowerShell depuis un serveur Debian vers une machine Windows et vice versa).
- **Renforcement de la Sécurité** : Continuer à améliorer les mesures de sécurité en intégrant des audits de sécurité réguliers et en implémentant des mécanismes de détection et de réponse aux intrusions.
- **Optimisation des Scripts** : Réviser et optimiser les scripts pour améliorer leur performance et leur fiabilité. Ajouter des fonctionnalités de personnalisation pour améliorer l'expérience utilisateur.




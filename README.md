# Projet de Gestion de Tâches à Distance via Script

## Introduction : Mise en Contexte

Ce projet a pour objectif de créer un script qui s’exécute sur une machine locale et qui effectue des tâches sur des machines distantes, toutes connectées sur le même réseau. Les tâches peuvent inclure des actions pour l'utilisateur telles que : 
- la création, suppression de compte et des demandes d'informations comme la date de la derniére connexion
  
Pour l'ordinateur :  

- arrêt, redémarrage de la machine ou des requêtes d’information comme la version de l'OS.
   
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

- **Système d'exploitation** :
  - OS : [Nom du système d'exploitation]
  - Version : [Version du système d'exploitation]
- **Langages de script** : Powershell/Bash
- **Outils de gestion de projet** : Jira
- **Contrôle de version** : Git
- **Outils de communication** : Discord/GoogleMeet
- **Automatisation des tâches** : 

## Difficultés Rencontrées

### Problèmes Techniques Rencontrés
- Mise en réseau des VM clients et serveurs, ping possible depuis les serveurs mais pas depuis les postes clients.
- [Description du problème 2]
- [Description du problème 3]

## Solutions Trouvées

### Solutions et Alternatives
- Configurations des IP fixes pour chaque VM et des pare-feu sur les postes clients pour autoriser les requêtes ICMP entrantes, test de connectivité via la commande PING.
- [Solution pour le problème 2]
- [Solution pour le problème 3]

## Améliorations Possibles

### Suggestions d’Améliorations Futures
- [Suggestion d'amélioration 1]
- [Suggestion d'amélioration 2]
- [Suggestion d'amélioration 3]

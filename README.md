# ChantierPlus

# Choix de l'architecture du projet : 

Architecture adopté : 

```
|-- firebase_options.dart # Configuration de Firebase
|-- main.dart # Point d'entrée de l'application
|-- core
  |-- service_locator.dart # Gestion des dépendances
  |-- service_result.dart # Classe pour gérer les résultats des services
  |-- configs
    |-- theme
      |-- app_colors.dart # Définitions des couleurs de l'application
      |-- app_theme.dart # Thème principal de l'application
|-- common
  |-- presentation
    |-- splash # Dossier pour les composants liés à l'écran de démarrage
  |-- widgets
    |-- inputs
|-- features
  |-- auth # Fonctionnalité d'authentification
    |-- mapper # Logique de mappage des modèles
    |-- application (services)
      |-- services # Services liés à l'authentification
    |-- data
      |-- models (Dto) # Modèles de transfert de données
      |-- repository # Interface de repository pour l'authentification
      |-- source # Source de données (ex. Firebase)
    |-- domain
      |-- entities # Entités du domaine (ex. Utilisateur)
      |-- repository # Implémentation du repository
    |-- presentation
      |-- bloc # Gestion d'état avec BLoC
      |-- page # Pages de l'interface utilisateur
      |-- widget # Widgets spécifiques à l'authentification
  |-- construction_site_management # Fonctionnalité de gestion de chantiers
    |-- mapper # Logique de mappage des modèles pour la gestion de chantiers
    |-- ... # Autres fichiers spécifiques à cette fonctionnalité

```

> [Doc sur l'architecture du projet](./READMES/project_structure_README.md)
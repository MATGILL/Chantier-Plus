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

## Intégration de Mapbox

Ce projet utilise Mapbox pour offrir des fonctionnalités de cartographie et de recherche d'adresses dans l'application. L'objectif est de permettre une visualisation interactive des sites de construction ainsi qu'une recherche facile des localisations.

---

### **1. Affichage des sites sur une carte**

Dans la classe `MapPage`, une carte Mapbox est affichée grâce au package `flutter_map`. Les sites de construction sont représentés par des marqueurs dynamiques. Chaque marqueur affiche l'icône d'un plot de travaux et permet, lorsqu'on clique dessus, de naviguer vers un écran de détails du site.

#### **Fonctionnalités principales :**
- **Carte Mapbox interactive** : La carte est centrée sur une zone définie et utilise un style personnalisé de Mapbox.
- **Marqueurs dynamiques** : Chaque site de construction est affiché à sa position géographique sous forme de marqueur.
- **Navigation aux détails** : Cliquer sur un marqueur redirige vers l'écran des détails du site.

---

### **2. Recherche d’adresses avec autocomplétion**

La classe `AutoCompleteSearchLocation` intègre la recherche d'adresses via l'API Places de Mapbox. Elle permet aux utilisateurs de saisir une adresse et de sélectionner une suggestion pour récupérer ses coordonnées GPS.

#### **Fonctionnalités principales :**
- **Autocomplétion** : Recherche en temps réel des adresses correspondant à la saisie.
- **Sélection des résultats** : Une fois une adresse sélectionnée, son nom et ses coordonnées GPS sont renvoyés pour utilisation (par exemple, pour localiser un site ou enregistrer une adresse).

---
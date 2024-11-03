### Choix de la structure de projet

Dans notre projet Flutter, nous avons adopté une structure organisée pour assurer une séparation claire des responsabilités et une évolutivité optimale. Voici les principales caractéristiques de notre architecture :

- **Modularité** : Chaque fonctionnalité (ou feature) est isolée dans son propre dossier sous le répertoire `features`, ce qui permet de gérer facilement les composants spécifiques sans affecter les autres parties de l'application. Par exemple, la gestion des utilisateurs se trouve dans le module `auth`, tandis que la gestion des chantiers est dans `construction_site_management`.

- **Séparation des couches** : Nous avons implémenté une architecture en couches où la logique métier, les données et la présentation sont clairement distinctes. Par exemple :
  - La **couche de domaine** contient les entités et les interfaces de repository, permettant de définir des contrats clairs pour l'accès aux données (par exemple, `auth_repository.dart`).
  - La **couche d'application** gère les services, encapsulant la logique métier et les interactions avec la couche de données (par exemple, `auth_service.dart`).
  - La **couche de présentation** se concentre sur l'interface utilisateur, en intégrant les widgets, les pages et les blocs pour la gestion de l'état (par exemple, `auth_screen.dart`, `home_screen.dart`).

- **Réutilisabilité et personnalisation** : Les composants réutilisables tels que les widgets personnalisés et les thèmes sont placés sous `common`, facilitant ainsi leur utilisation à travers différentes fonctionnalités de l'application. Cela permet de maintenir une cohérence visuelle et fonctionnelle dans toute l'application.

- **Gestion des configurations** : La configuration du thème et des couleurs est centralisée dans le dossier `core/configs/theme`, ce qui permet une modification rapide et globale du style de l'application.

- **Source de données intégrée** : Le dossier `data` dans chaque module contient les modèles (DTO), les implémentations des repositories, et les services spécifiques aux sources de données (comme `auth_firebase_service.dart`), facilitant ainsi l'accès et la gestion des données.

Cette structure favorise la lisibilité, la maintenabilité et la collaboration au sein de l'équipe de développement, tout en permettant une croissance future sans complexité excessive.

```
|-- firebase_options.dart # configuration de firebase
|-- main.dart
|-- core
  |-- service_locator.dart
  |-- service_result.dart
  |-- configs
    |-- theme
      |-- app_colors.dart
      |-- app_theme.dart
|-- common
  |-- presentation
    |-- splash.dart
    |-- splash
  |-- widgets
    |-- inputs
      |-- cutom_text_form_field.dart
|-- features
  |-- auth
    |-- mapper
    |-- application(services)
      |-- services
    |-- data
      |-- models (Dto)
      |-- repository
      |-- source
    |-- domain
      |-- entities
      |-- repository
    |-- presentation
      |-- bloc
      |-- page
      |-- widget
  |-- construction_site management
    |-- mapper
    |-- ...
    ```

# ChantierPlus

# Choix de l'architecture du projet : 

Architecture adopté : 

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

> [Doc sur l'architecture du projet](./READMES/project_structure_README.md)
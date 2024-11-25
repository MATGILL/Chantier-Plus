import 'package:flutter/material.dart';

enum Status {
  notStarted("Not Started"),
  inProgress("In Progress"),
  over("Over"),
  stopped("Stopped");

  final String name;
  const Status(this.name);
}

extension StatusExtension on Status {
  /// Convertit une chaîne de caractères en une valeur de l'énumération `Status`.
  /// Renvoie une exception si la chaîne ne correspond à aucune valeur.
  static Status fromString(String statusString) {
    switch (statusString.toLowerCase()) {
      case 'not_started':
        return Status.notStarted;
      case 'in_progress':
        return Status.inProgress;
      case 'stopped':
        return Status.stopped;
      case 'over':
        return Status.over;
      default:
        throw ArgumentError('Invalid status string: $statusString');
    }
  }

  static Color getStatusColor(Status status) {
    switch (status) {
      case Status.notStarted:
        return Colors.grey; // Non commencé
      case Status.inProgress:
        return Colors.green; // En cours
      case Status.over:
        return Colors.blue; // Terminé
      case Status.stopped:
        return Colors.red; // Arrêté
      default:
        return Colors.black; // Couleur par défaut
    }
  }

  String get firestoreFormat {
    switch (this) {
      case Status.notStarted:
        return "not_started"; // Non commencé
      case Status.inProgress:
        return "in_progress"; // En cours
      case Status.over:
        return "over"; // Terminé
      case Status.stopped:
        return "stopped"; // Arrêté
      default:
        return ""; // Icône par défaut
    }
  }

  /// Retourne une icône appropriée pour chaque statut.
  String get statusIcon {
    switch (this) {
      case Status.notStarted:
        return "⌛️"; // Non commencé
      case Status.inProgress:
        return "🏗️"; // En cours
      case Status.over:
        return "✅"; // Terminé
      case Status.stopped:
        return "⚠️"; // Arrêté
      default:
        return ""; // Icône par défaut
    }
  }
}

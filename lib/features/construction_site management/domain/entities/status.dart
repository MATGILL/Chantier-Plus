enum Status { notStarted, doing, stopped, over }

extension StatusExtension on Status {
  /// Convertit une chaîne de caractères en une valeur de l'énumération `Status`.
  /// Renvoie une exception si la chaîne ne correspond à aucune valeur.
  static Status fromString(String statusString) {
    switch (statusString.toLowerCase()) {
      case 'not_started':
        return Status.notStarted;
      case 'doing':
        return Status.doing;
      case 'stopped':
        return Status.stopped;
      case 'over':
        return Status.over;
      default:
        throw ArgumentError('Invalid status string: $statusString');
    }
  }
}

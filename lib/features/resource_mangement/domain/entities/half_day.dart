enum HalfDay { morning, afternoon }

extension HalfDayExtension on HalfDay {
  static HalfDay fromString(String value) {
    switch (value.toLowerCase()) {
      case 'MORNING':
        return HalfDay.morning;
      case 'AFTERNOON':
        return HalfDay.afternoon;
      default:
        return HalfDay.morning;
    }
  }

  // Convertir l'énumération en une chaîne de caractères pour Firebase
  String toFirebaseFormat() {
    switch (this) {
      case HalfDay.morning:
        return 'MORNING';
      case HalfDay.afternoon:
        return 'AFTERNOON';
    }
  }
}

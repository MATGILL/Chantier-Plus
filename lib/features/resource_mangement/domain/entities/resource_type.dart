enum ResourceType { vehicle, supply }

extension ResourceTypeExtension on ResourceType {
  String get displayName {
    switch (this) {
      case ResourceType.vehicle:
        return "Véhicule";
      case ResourceType.supply:
        return "Fourniture";
      default:
        return '';
    }
  }
}

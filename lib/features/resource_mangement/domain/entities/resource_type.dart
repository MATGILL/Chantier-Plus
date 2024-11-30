enum ResourceType { vehicle, gear, supply }

extension ResourceTypeExtension on ResourceType {
  String get displayName {
    switch (this) {
      case ResourceType.vehicle:
        return "Véhicule";
      case ResourceType.gear:
        return "Matériel";
      case ResourceType.supply:
        return "Materiaux";
      default:
        return '';
    }
  }
}

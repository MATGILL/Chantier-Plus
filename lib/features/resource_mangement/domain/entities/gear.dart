import 'package:chantier_plus/features/resource_mangement/domain/entities/gear_type.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';
import 'package:equatable/equatable.dart';

class Gear extends Equatable {
  final String id;
  final GearType type;
  final int availableQuantity;
  final List<Unavailability> unavailabilities;

  const Gear({
    required this.id,
    required this.type,
    required this.availableQuantity,
    required this.unavailabilities,
  });

  Gear copyWith({
    String? id,
    GearType? type,
    int? availableQuantity,
    List<Unavailability>? unavailabilities,
  }) {
    return Gear(
      id: id ?? this.id,
      type: type ?? this.type,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      unavailabilities: unavailabilities ?? this.unavailabilities,
    );
  }

  @override
  List<Object?> get props => [id, type, availableQuantity, unavailabilities];

  Gear.empty()
      : id = '',
        type = GearType.hammer,
        availableQuantity = 0,
        unavailabilities = const [];

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(), // Convertir GearType en chaîne si nécessaire
      'availableQuantity': availableQuantity,
      'unavailabilities': unavailabilities
          .map((unavailability) => unavailability.toJson())
          .toList(),
    };
  }

  // fromJson
  factory Gear.fromJson(Map<String, dynamic> json) {
    return Gear(
      id: json['id'] as String,
      type: GearType.values.firstWhere((e) =>
          e.toString() == 'GearType.${json['type']}'), // Exemple pour GearType
      availableQuantity: json['availableQuantity'] as int,
      unavailabilities: (json['unavailabilities'] as List)
          .map((unavailabilityJson) =>
              Unavailability.fromJson(unavailabilityJson))
          .toList(),
    );
  }
}

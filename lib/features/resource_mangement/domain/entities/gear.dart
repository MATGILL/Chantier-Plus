import 'package:chantier_plus/features/resource_mangement/domain/entities/gear_type.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/resource.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';

class Gear extends Resource {
  final GearType type;
  final int availableQuantity;

  const Gear({
    required String id,
    required this.type,
    required this.availableQuantity,
    required List<Unavailability> unavailabilities,
  }) : super(id: id, unavailabilities: unavailabilities);

  @override
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'availableQuantity': availableQuantity,
      'unavailabilities': unavailabilities
          .map((unavailability) => unavailability.toJson())
          .toList(),
    };
  }

  @override
  factory Gear.fromJson(Map<String, dynamic> json) {
    return Gear(
      id: json['id'] as String,
      type: GearType.values
          .firstWhere((e) => e.toString() == 'GearType.${json['type']}'),
      availableQuantity: json['availableQuantity'] as int,
      unavailabilities: (json['unavailabilities'] as List)
          .map((unavailabilityJson) =>
              Unavailability.fromJson(unavailabilityJson))
          .toList(),
    );
  }
}

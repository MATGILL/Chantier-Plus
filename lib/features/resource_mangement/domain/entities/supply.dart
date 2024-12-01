import 'package:chantier_plus/features/resource_mangement/domain/entities/resource.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';

class Supply extends Resource {
  final String name;
  final String type;

  const Supply({
    required super.id,
    required this.name,
    required this.type,
    required super.unavailabilities,
  });

  @override
  Supply copyWith({
    String? id,
    String? name,
    String? type,
    List<Unavailability>? unavailabilities,
  }) {
    return Supply(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      unavailabilities: unavailabilities ?? this.unavailabilities,
    );
  }

  @override
  List<Object?> get props => [id, name, type, unavailabilities];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'unavailabilities': unavailabilities.map((u) => u.toJson()).toList(),
    };
  }

  @override
  factory Supply.fromJson(Map<String, dynamic> json) {
    return Supply(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      unavailabilities: (json['unavailabilities'] as List)
          .map((u) => Unavailability.fromJson(u as Map<String, dynamic>))
          .toList(),
    );
  }
}

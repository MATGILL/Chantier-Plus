import 'package:chantier_plus/features/resource_mangement/domain/entities/resource.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';

class Vehicle extends Resource {
  final String brand;
  final String model;

  const Vehicle({
    required super.id,
    required this.brand,
    required this.model,
    required super.unavailabilities,
  });

  @override
  Vehicle copyWith({
    String? id,
    String? brand,
    String? model,
    List<Unavailability>? unavailabilities,
  }) {
    return Vehicle(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      unavailabilities: unavailabilities ?? this.unavailabilities,
    );
  }

  @override
  List<Object?> get props => [id, brand, model, unavailabilities];

  @override
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'model': model,
      'unavailabilities': unavailabilities.map((u) => u.toJson()).toList(),
    };
  }

  @override
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      unavailabilities: (json['unavailabilities'] as List)
          .map((u) => Unavailability.fromJson(u as Map<String, dynamic>))
          .toList(),
    );
  }
}

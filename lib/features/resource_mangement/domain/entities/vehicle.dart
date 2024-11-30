import 'package:equatable/equatable.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';

class Vehicle extends Equatable {
  final String id;
  final String brand;
  final String model;
  final List<Unavailability> unavailabilities;

  const Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.unavailabilities,
  });

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

  const Vehicle.empty()
      : id = '',
        brand = '',
        model = '',
        unavailabilities = const [];

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'unavailabilities': unavailabilities.map((u) => u.toJson()).toList(),
    };
  }

  // fromJson
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

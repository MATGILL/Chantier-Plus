import 'package:equatable/equatable.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';

abstract class Resource extends Equatable {
  final String id;
  final List<Unavailability> unavailabilities;

  const Resource({
    required this.id,
    required this.unavailabilities,
  });

  Resource copyWith({
    String? id,
    List<Unavailability>? unavailabilities,
  });

  @override
  List<Object?> get props => [id, unavailabilities];

  Map<String, dynamic> toJson();

  // Corrected factory method with function body
  factory Resource.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('This method should be implemented in subclasses');
  }
}

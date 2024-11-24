import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:equatable/equatable.dart';

class ConstructionSite extends Equatable {
  final String id;
  final String object;
  final DateTime startingDate;
  final int durationInHalfDays;
  final String location;
  final String clientContact;
  final Status status;
  final List<String> photos;
  final List<Anomaly> anomalies;
  // final List<Vehicle> vehicles;
  // final List<Material> materials;
  // final List<TeamMember> teamMembers;

  const ConstructionSite({
    required this.id,
    required this.object,
    required this.startingDate,
    required this.durationInHalfDays,
    required this.location,
    required this.clientContact,
    required this.status,
    required this.photos,
    this.anomalies = const [],
    // this.vehicles = const [],
    // this.materials = const [],
    // this.teamMembers = const [],
  });

  @override
  List<Object?> get props => [
        id,
        object,
        startingDate,
        durationInHalfDays,
        location,
        clientContact,
        status,
        photos,
        anomalies,
        // vehicles,
        // materials,
        // teamMembers,
      ];
}

import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:equatable/equatable.dart';

class ConstructionSite extends Equatable {
  final String id;
  final String object;
  final int durationInHalfDays;
  final DateTime startingDate;
  final HalfDay halfDayStarting;
  final String location;
  final String clientContact;
  final Status status;
  final List<String> photos;
  final List<Anomaly> anomalies;
  final int anomalyNumber;
  // final List<Vehicle> vehicles;
  // final List<Material> materials;
  // final List<TeamMember> teamMembers;

  const ConstructionSite({
    required this.id,
    required this.object,
    required this.durationInHalfDays,
    required this.startingDate,
    required this.halfDayStarting,
    required this.location,
    required this.clientContact,
    required this.status,
    required this.photos,
    this.anomalyNumber = 0,
    this.anomalies = const [],
    // this.vehicles = const [],
    // this.materials = const [],
    // this.teamMembers = const [],
  });

  @override
  List<Object?> get props => [
        id,
        object,
        durationInHalfDays,
        startingDate,
        halfDayStarting,
        location,
        clientContact,
        status,
        photos,
        anomalyNumber,
        anomalies,
        // vehicles,
        // materials,
        // teamMembers,
      ];

  ConstructionSite copyWith(
      {String? id,
      String? object,
      int? durationInHalfDays,
      DateTime? startingDate,
      HalfDay? halfDayStarting,
      DateTime? endingDate,
      String? location,
      String? clientContact,
      Status? status,
      List<String>? photos,
      int? anomalyNumber,
      List<Anomaly>? anomalies}) {
    return ConstructionSite(
        id: id ?? this.id,
        object: object ?? this.object,
        durationInHalfDays: durationInHalfDays ?? this.durationInHalfDays,
        startingDate: startingDate ?? this.startingDate,
        halfDayStarting: halfDayStarting ?? this.halfDayStarting,
        location: location ?? this.location,
        clientContact: clientContact ?? this.clientContact,
        status: status ?? this.status,
        photos: photos ?? this.photos,
        anomalyNumber: anomalyNumber ?? this.anomalyNumber,
        anomalies: anomalies ?? this.anomalies);
  }
}

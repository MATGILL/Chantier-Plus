import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ConstructionSiteLightDto extends Equatable {
  final String id;
  final String object;
  final int durationInHalfDays;
  final DateTime startingDate;
  final HalfDay halfDayStarting;
  final DateTime endingDate;
  final String location;
  final GeoPoint geoPoint;
  final String clientContact;
  final String status;
  final List<String> photos;
  final List<String> anomalies;

  const ConstructionSiteLightDto(
      {required this.id,
      required this.object,
      required this.durationInHalfDays,
      required this.startingDate,
      required this.halfDayStarting,
      required this.endingDate,
      required this.location,
      required this.geoPoint,
      required this.clientContact,
      required this.status,
      required this.photos,
      required this.anomalies});

  @override
  List<Object?> get props => [
        id,
        object,
        durationInHalfDays,
        startingDate,
        halfDayStarting,
        endingDate,
        location,
        geoPoint,
        clientContact,
        status,
        photos,
        anomalies
      ];

  /// Conversion depuis Firestore (fromJson)
  factory ConstructionSiteLightDto.fromJson(Map<String, dynamic> json) {
    return ConstructionSiteLightDto(
        id: "",
        object: json['object'] as String,
        durationInHalfDays: json['duration_in_half_days'] as int,
        startingDate: DateTime.now(),
        halfDayStarting:
            HalfDayExtension.fromString(json['halfDayStarting'] ?? ""),
        endingDate: DateTime.now(),
        location: json['location'] as String,
        geoPoint: json['geoPoint'] as GeoPoint,
        clientContact: json['client_contact'] as String,
        status: json['status'] as String,
        photos: List<String>.from(
          json['photos'] ?? [],
        ),
        anomalies: List<String>.from(json['anomalies'] ?? []));
  }

  /// Conversion vers Firestore (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'duration_in_half_days': durationInHalfDays,
      'startingDate': startingDate.toIso8601String(),
      'halfDayStarting': halfDayStarting.toFirebaseFormat(),
      'endingDate': endingDate.toIso8601String(),
      'location': location,
      'geoPoint': geoPoint,
      'client_contact': clientContact,
      'status': status,
      'photos': photos,
      'anomalies': anomalies
    };
  }

  ConstructionSiteLightDto copyWith(
      {String? id,
      String? object,
      int? durationInHalfDays,
      DateTime? startingDate,
      HalfDay? halfDayStarting,
      DateTime? endingDate,
      String? location,
      GeoPoint? geoPoint,
      String? clientContact,
      String? status,
      List<String>? photos,
      List<String>? anomalies}) {
    return ConstructionSiteLightDto(
        id: id ?? this.id,
        object: object ?? this.object,
        durationInHalfDays: durationInHalfDays ?? this.durationInHalfDays,
        startingDate: startingDate ?? this.startingDate,
        halfDayStarting: halfDayStarting ?? this.halfDayStarting,
        endingDate: endingDate ?? this.endingDate,
        location: location ?? this.location,
        geoPoint: geoPoint ?? this.geoPoint,
        clientContact: clientContact ?? this.clientContact,
        status: status ?? this.status,
        photos: photos ?? this.photos,
        anomalies: anomalies ?? this.anomalies);
  }
}

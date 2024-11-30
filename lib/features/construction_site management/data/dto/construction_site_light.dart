import 'package:equatable/equatable.dart';

class ConstructionSiteLightDto extends Equatable {
  final String id;
  final String object;
  final DateTime startingDate;
  final int durationInHalfDays;
  final String location;
  final String clientContact;
  final String status;
  final List<String> photos;
  final List<String> anomalies;

  const ConstructionSiteLightDto(
      {required this.id,
      required this.object,
      required this.startingDate,
      required this.durationInHalfDays,
      required this.location,
      required this.clientContact,
      required this.status,
      required this.photos,
      required this.anomalies});

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
        anomalies
      ];

  /// Conversion depuis Firestore (fromJson)
  factory ConstructionSiteLightDto.fromJson(Map<String, dynamic> json) {
    return ConstructionSiteLightDto(
        id: "",
        object: json['object'] as String,
        startingDate: DateTime.now(),
        durationInHalfDays: json['duration_in_half_days'] as int,
        location: json['location'] as String,
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
      'startingDate': startingDate.toIso8601String(),
      'duration_in_half_days': durationInHalfDays,
      'location': location,
      'client_contact': clientContact,
      'status': status,
      'photos': photos,
      'anomalies': anomalies
    };
  }

  ConstructionSiteLightDto copyWith(
      {String? id,
      String? object,
      DateTime? startingDate,
      int? durationInHalfDays,
      String? location,
      String? clientContact,
      String? status,
      List<String>? photos,
      List<String>? anomalies}) {
    return ConstructionSiteLightDto(
        id: id ?? this.id,
        object: object ?? this.object,
        startingDate: startingDate ?? this.startingDate,
        durationInHalfDays: durationInHalfDays ?? this.durationInHalfDays,
        location: location ?? this.location,
        clientContact: clientContact ?? this.clientContact,
        status: status ?? this.status,
        photos: photos ?? this.photos,
        anomalies: anomalies ?? this.anomalies);
  }
}

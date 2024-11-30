import 'package:equatable/equatable.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';

class Unavailability extends Equatable {
  final String id;
  final DateTime startingDate;
  final HalfDay halfDayStarting;
  final DateTime endingDate;
  final HalfDay halfDayEnding;

  const Unavailability({
    required this.id,
    required this.startingDate,
    required this.halfDayStarting,
    required this.endingDate,
    required this.halfDayEnding,
  });

  Unavailability copyWith({
    String? id,
    DateTime? startingDate,
    HalfDay? halfDayStarting,
    DateTime? endingDate,
    HalfDay? halfDayEnding,
  }) {
    return Unavailability(
      id: id ?? this.id,
      startingDate: startingDate ?? this.startingDate,
      halfDayStarting: halfDayStarting ?? this.halfDayStarting,
      endingDate: endingDate ?? this.endingDate,
      halfDayEnding: halfDayEnding ?? this.halfDayEnding,
    );
  }

  @override
  List<Object?> get props =>
      [id, startingDate, halfDayStarting, endingDate, halfDayEnding];

  Unavailability.empty()
      : id = '',
        startingDate = DateTime.now(),
        halfDayStarting = HalfDay.morning,
        endingDate = DateTime.now(),
        halfDayEnding = HalfDay.afternoon;

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startingDate': startingDate.toIso8601String(),
      'halfDayStarting': halfDayStarting.name,
      'endingDate': endingDate.toIso8601String(),
      'halfDayEnding': halfDayEnding.name,
    };
  }

  // fromJson
  factory Unavailability.fromJson(Map<String, dynamic> json) {
    return Unavailability(
      id: json['id'] as String,
      startingDate: DateTime.parse(json['startingDate'] as String),
      halfDayStarting: HalfDay.values.byName(json['halfDayStarting'] as String),
      endingDate: DateTime.parse(json['endingDate'] as String),
      halfDayEnding: HalfDay.values.byName(json['halfDayEnding'] as String),
    );
  }
}

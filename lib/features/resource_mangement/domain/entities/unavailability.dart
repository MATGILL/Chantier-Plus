import 'package:chantier_plus/features/resource_mangement/domain/entities/period.dart';
import 'package:equatable/equatable.dart';

class Unavailability extends Equatable {
  final String id;
  final Period period;
  //final Period period;

  const Unavailability({required this.id, required this.period});

  Unavailability copyWith({String? id, Period? period}) {
    return Unavailability(id: id ?? this.id, period: period ?? this.period);
  }

  @override
  List<Object?> get props => [id, period];

  Unavailability.empty()
      : id = '',
        period = Period.empty();

  // toJson
  Map<String, dynamic> toJson() {
    return {'id': id, 'periods': period.toJson()};
  }

  // fromJson
  factory Unavailability.fromJson(Map<String, dynamic> json) {
    return Unavailability(
        id: json['id'] as String, period: Period.fromJson(json));
  }
}

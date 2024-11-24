import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class Anomaly extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<String> photos;
  final UserEntity author;

  const Anomaly({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.photos,
    required this.author,
  });

  @override
  List<Object?> get props => [id, title, description, date, photos, author];
}

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

  Anomaly copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    List<String>? photos,
    UserEntity? author,
  }) {
    return Anomaly(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      photos: photos ?? this.photos,
      author: author ?? this.author,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date, photos, author];
}

import 'package:equatable/equatable.dart';

class Anomaly extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<String> photos;
  final String authorId;
  final String constructionSiteId;

  const Anomaly(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.photos,
      required this.authorId,
      required this.constructionSiteId});

  Anomaly copyWith(
      {String? id,
      String? title,
      String? description,
      DateTime? date,
      List<String>? photos,
      String? authorId,
      String? constructionSiteId}) {
    return Anomaly(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        photos: photos ?? this.photos,
        authorId: authorId ?? this.authorId,
        constructionSiteId: constructionSiteId ?? this.constructionSiteId);
  }

  @override
  List<Object?> get props =>
      [id, title, description, date, photos, authorId, constructionSiteId];

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'photos': photos,
      'authorId': authorId,
      'constructionSiteid': constructionSiteId
    };
  }

  // fromJson
  factory Anomaly.fromJson(Map<String, dynamic> json) {
    return Anomaly(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        date: DateTime.parse(json['date'] as String),
        photos: List<String>.from(json['photos'] as List),
        authorId: json['authorId'] as String,
        constructionSiteId: json['constructionSiteId'] as String);
  }
}

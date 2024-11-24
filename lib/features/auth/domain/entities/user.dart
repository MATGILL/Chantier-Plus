import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  String? userId;
  String? email;
  String? fullName;
  String? role;

  UserEntity({this.userId, this.email, this.fullName, this.role});

  /// Convertit un objet JSON en une instance de `UserEntity`.
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      role: json['role'] as String?,
    );
  }

  /// Convertit une instance de `UserEntity` en JSON.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [userId, email, fullName, role];
}

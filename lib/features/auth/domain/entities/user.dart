import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  String? userId;
  String? email;
  String? fullName;
  String? role;

  UserEntity({this.userId, this.email, this.fullName, this.role});

  @override
  List<Object?> get props => [userId, email, fullName, role];
}

part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserEntity? user;

  const AuthenticationState._({required this.status, this.user});

  const AuthenticationState.unknown()
      : this._(status: AuthenticationStatus.unknown);

  const AuthenticationState.authenticated(UserEntity user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [user, status];
}

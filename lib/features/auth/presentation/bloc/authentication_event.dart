part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class AuthenticationSubscriptionRequested extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

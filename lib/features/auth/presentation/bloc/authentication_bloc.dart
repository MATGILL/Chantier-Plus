import 'dart:async';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/domain/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthService _authService;
  AuthenticationBloc()
      : _authService = serviceLocator<AuthService>(),
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await for (final firebaseUser in FirebaseAuth.instance.authStateChanges()) {
      if (firebaseUser != null) {
        try {
          // Récupérer l'utilisateur avec le service
          final result = await _authService.getUserById(firebaseUser.uid);
          if (result.success) {
            emit(AuthenticationState.authenticated(result.content!));
          } else {
            emit(const AuthenticationState.unauthenticated());
          }
        } catch (e) {
          emit(const AuthenticationState.unauthenticated());
        }
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    }
  }

  void _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _firebaseAuth.signOut();
  }
}

import 'package:chantier_plus/features/construction_site%20management/presentation/pages/navigation_chef.dart';
import 'package:chantier_plus/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chantier_plus/features/auth/presentation/page/auth_screen.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/resp_home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          final user = state.user;
          if (user?.role == 'RESP') {
            return const RespHomeScreen();
          } else if (user?.role == 'CHEF') {
            return const NavigationChef();
          } else {
            _showError(context, 'Rôle utilisateur inconnu.');
          }
        } else if (state.status == AuthenticationStatus.unauthenticated) {
          return const AuthScreen();
        }
        return const AuthScreen();
      },
    );
  }

  void _showError(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    });
  }
}

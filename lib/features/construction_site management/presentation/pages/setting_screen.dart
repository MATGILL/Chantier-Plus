import 'package:chantier_plus/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            // Implémente ta logique de déconnexion ici
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested());
          },
          icon: const Icon(Icons.logout),
          label: const Text("Logout"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}

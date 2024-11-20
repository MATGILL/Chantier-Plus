import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/presentation/page/auth_screen.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/chef_home_screen.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/resp_home_screen.dart';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const AuthScreen();
        }

        // Si l'utilisateur est authentifié, on récupère son role
        final userId = snapshot.data?.uid;

        if (userId == null) {
          return const AuthScreen();
        }

        return FutureBuilder<ServiceResult<String>>(
          future: serviceLocator<AuthRepository>().getUserRoleById(userId),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }

            if (roleSnapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Erreur lors de la récupération du rôle')));
              });
              return const AuthScreen();
            }

            if (roleSnapshot.hasData) {
              String role = roleSnapshot.data?.content ?? '';

              // Selon le rôle, on redirige vers la bonne page
              if (role == 'RESP') {
                return const RespHomeScreen();
              } else if (role == 'CHEF') {
                return const ChefHomeScreen();
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mauvais rôle.')));
                });
                return const AuthScreen();
              }
            }

            return const Center(child: Text('Erreur inconnue'));
          },
        );
      },
    );
  }
}

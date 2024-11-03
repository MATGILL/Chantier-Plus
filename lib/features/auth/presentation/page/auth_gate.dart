import 'package:chantier_plus/features/auth/presentation/page/auth_screen.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/home_screen.dart';
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

        return const HomeScreen();
      },
    );
  }
}

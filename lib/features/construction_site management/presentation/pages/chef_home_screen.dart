import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChefHomeScreen extends StatelessWidget {
  const ChefHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Chef"),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("logOut"))
          ],
        ),
      ),
    );
  }
}

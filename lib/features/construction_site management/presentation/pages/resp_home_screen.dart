import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RespHomeScreen extends StatelessWidget {
  const RespHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Resp"),
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

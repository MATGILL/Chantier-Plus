import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/construction_site_home_screen_chef.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChefHomeScreen extends StatelessWidget {
  const ChefHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: ConstructionSiteListScreenChef(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text("logOut"),
          ),
        ],
      ),
    );
  }
}

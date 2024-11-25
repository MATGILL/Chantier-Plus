import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/construction_site_home_screen_chef.dart';
import 'package:flutter/material.dart';

class ChefHomeScreen extends StatelessWidget {
  const ChefHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ConstructionSiteListScreenChef(),
          ),
        ],
      ),
    );
  }
}

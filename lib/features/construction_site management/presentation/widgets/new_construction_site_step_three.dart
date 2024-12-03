import 'package:flutter/material.dart';

class NewConstructionSiteStepThree extends StatelessWidget {
  const NewConstructionSiteStepThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Exemple : Véhicules, Matériels, Autres
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Véhicules"),
              Tab(text: "Matériels"),
              Tab(text: "Autres"),
            ],
          ),
          SizedBox(
            height: 200, // Vous pouvez ajuster la hauteur
            child: const TabBarView(
              children: [
                Center(child: Text("Sélectionnez des véhicules")),
                Center(child: Text("Sélectionnez des matériels")),
                Center(child: Text("Sélectionnez autres ressources")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:chantier_plus/features/resource_mangement/presentation/pages/create_resource_screen.dart';
import 'package:flutter/material.dart';

class ResourceListScreen extends StatelessWidget {
  const ResourceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Ressources'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers un autre écran
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  const CreateResourceScreen(), // L'écran cible
            ),
          );
        },
        child: Icon(Icons.add),
      ), // Déplacer le bouton au-dessus
    );
  }
}

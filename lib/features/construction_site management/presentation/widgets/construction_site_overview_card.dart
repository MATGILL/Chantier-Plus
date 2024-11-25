import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:flutter/material.dart';

class ConstructionSiteOverviewCard extends StatefulWidget {
  ConstructionSiteOverviewCard({super.key});

  @override
  State<ConstructionSiteOverviewCard> createState() =>
      _ConstructionSiteOverviewCardState();
}

class _ConstructionSiteOverviewCardState
    extends State<ConstructionSiteOverviewCard> {
  //Mock object
  final constructionSite = ConstructionSite(
    id: "site123",
    object: "Rénovation d'appartement",
    startingDate: DateTime(2024, 12, 1),
    durationInHalfDays: 20,
    location: "12 Rue des Lilas, Paris",
    clientContact: "Jean Dupont - 0601020304",
    status: Status.inProgress,
    photos: const [
      "https://batiadvisor.fr/wp-content/uploads/2020/07/imprevus-chantier.jpg",
      "https://example.com/photo2.jpg",
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBackground,
      elevation: 4,
      margin: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre et localisation dans un ListTile
          ListTile(
            title: Text(
              constructionSite.object,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("📍${constructionSite.location}"),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text("Modifier")),
                const PopupMenuItem(child: Text("Supprimer")),
              ],
            ),
          ),

          // Dropdown pour le statut
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
            child: DropdownMenu<String>(
              initialSelection: constructionSite.status.name,
              dropdownMenuEntries: [
                Status.notStarted,
                Status.inProgress,
                Status.over,
                Status.stopped
              ]
                  .map(
                    (status) => DropdownMenuEntry<String>(
                      value: status.name,
                      label: "${status.statusIcon} ${status.name}",
                    ),
                  )
                  .toList(),
              menuStyle: MenuStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
              ),
              inputDecorationTheme: InputDecorationTheme(
                alignLabelWithHint: false,
                isDense: true,
                constraints: BoxConstraints.tight(const Size.fromHeight(40)),
              ),
              onSelected: changeStatus,
            ),
          ),

          // Image du chantier
          if (constructionSite.photos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.network(
                constructionSite.photos[0],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          // Description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "📞 ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const TextSpan(
                    text: "contact : ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: constructionSite.clientContact,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          // Bouton "Signaler un problème"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 32,
                  child: ElevatedButton.icon(
                    onPressed: reportProblem,
                    icon: const Icon(Icons.error_outline, color: Colors.red),
                    label: const Text(
                      "Signaler un problème",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changeStatus(status) {
    //TODO : implemenet changeStatus
    throw UnimplementedError();
  }

  void reportProblem() {
    //TODO : implemenet reportProblem
    throw UnimplementedError();
  }
}

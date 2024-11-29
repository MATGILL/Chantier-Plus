import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/construction_iste_bloc/construction_site_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/create_anomaly_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConstructionSiteOverviewCard extends StatefulWidget {
  final ConstructionSite constructionSite;
  const ConstructionSiteOverviewCard(
      {super.key, required this.constructionSite});

  @override
  State<ConstructionSiteOverviewCard> createState() =>
      _ConstructionSiteOverviewCardState();
}

class _ConstructionSiteOverviewCardState
    extends State<ConstructionSiteOverviewCard> {
  @override
  Widget build(BuildContext context) {
    final ConstructionSite constructionSite = widget.constructionSite;

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
            child: DropdownMenu<Status>(
              width: MediaQuery.of(context).size.width,
              initialSelection: constructionSite.status,
              dropdownMenuEntries: [
                Status.notStarted,
                Status.inProgress,
                Status.over,
                Status.stopped
              ]
                  .map(
                    (status) => DropdownMenuEntry<Status>(
                      value: status,
                      label: "${status.statusIcon} ${status.name}",
                    ),
                  )
                  .toList(),
              menuStyle: MenuStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
              ),
              inputDecorationTheme: InputDecorationTheme(
                alignLabelWithHint: true,
                isDense: true,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5)),
                constraints: BoxConstraints.tight(const Size.fromHeight(45)),
              ),
              onSelected: (status) {
                changeStatus(context, constructionSite.id, status!);
              },
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
          if (constructionSite.photos.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                "assets/images/Image_not_found.png",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
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
                    onPressed: () => reportProblem(constructionSite.id),
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

  void changeStatus(BuildContext context, String siteId, Status newStatus) {
    // Accède au bloc via le contexte
    final constructionSiteBloc = context.read<ConstructionSiteBloc>();

    // Émet un événement pour changer le statut
    constructionSiteBloc.add(ChangeConstructionSiteStatus(siteId, newStatus));
  }

  void reportProblem(String siteId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAnomalyScreen(
          constructionSiteId: siteId,
        ),
      ),
    );
  }
}

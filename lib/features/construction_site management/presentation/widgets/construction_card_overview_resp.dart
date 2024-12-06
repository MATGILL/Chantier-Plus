import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:flutter/material.dart';

class ConstructionSiteCardOverviewResp extends StatelessWidget {
  final GestureTapCallback _onTap;
  final void Function() onDelete; // Fonction de suppression
  final ConstructionSite _constructionSite;

  ConstructionSiteCardOverviewResp({
    super.key,
    required this.onDelete,
    required GestureTapCallback onTap,
    required ConstructionSite constructionSite,
  })  : _constructionSite = constructionSite,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    // Default image in case of error or no photos.
    var defauldImage = Image.asset(
      "assets/images/Image_not_found.png",
      height: 64.0,
      width: 64.0,
      fit: BoxFit.cover,
    );

    return GestureDetector(
      onTap: _onTap,
      child: Card(
        color: AppColors.lightBackground,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: _constructionSite.photos.isNotEmpty
                        ? Image.network(
                            _constructionSite.photos[0],
                            height: 64.0,
                            width: 64.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return defauldImage;
                            },
                          )
                        : defauldImage,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _constructionSite.object,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        SelectableText(
                          "📞 : ${_constructionSite.clientContact}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 2.0,
              right: 20.0,
              child: Text(
                "${_constructionSite.status.statusIcon} ${_constructionSite.status.name}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            // Ajout du bouton de suppression
            Positioned(
              top: 20.0,
              right: 10.0,
              child: IconButton(
                icon: Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () {
                  // Demander confirmation avant de supprimer
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour afficher la confirmation de suppression
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Êtes-vous sûr de vouloir supprimer ce chantier ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                onDelete(); // Appel de la logique de suppression
                Navigator.of(context).pop();
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}

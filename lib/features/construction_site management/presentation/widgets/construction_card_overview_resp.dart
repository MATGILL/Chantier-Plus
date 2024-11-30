import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:flutter/material.dart';

class ConstructionSiteCardOverviewResp extends StatelessWidget {
  final ConstructionSite _constructionSite;
  final VoidCallback onIconPressed;

  const ConstructionSiteCardOverviewResp({
    super.key,
    required ConstructionSite constructionSite,
    required this.onIconPressed,
  }) : _constructionSite = constructionSite;

  @override
  Widget build(BuildContext context) {
    //Default image in case of error or no photos.
    var defauldImage = Image.asset(
      "assets/images/Image_not_found.png",
      height: 64.0,
      width: 64.0,
      fit: BoxFit.cover,
    );

    return Card(
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
                      ? Image.network(_constructionSite.photos[0],
                          height: 64.0, width: 64.0, fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                          return defauldImage;
                        })
                      : defauldImage,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _constructionSite.object,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
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
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: onIconPressed,
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
        ],
      ),
    );
  }
}

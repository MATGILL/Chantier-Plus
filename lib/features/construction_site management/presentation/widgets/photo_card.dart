import 'dart:io';

import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final int index;
  final String? photoUrl;
  final VoidCallback onAddPhoto;
  final VoidCallback onRemovePhoto;

  const PhotoCard({
    super.key,
    this.photoUrl,
    required this.onAddPhoto,
    required this.onRemovePhoto,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      children: [
        // Affichage de l'image si elle est définie
        if (photoUrl != null)
          Positioned.fill(
            child: Image.file(
              File(
                photoUrl!,
              ),
              fit: BoxFit.cover,
            ),
          ),

        // Bouton "+" ou "×"
        Positioned(
          bottom: 1.0,
          right: 1.0,
          child: FloatingActionButton(
            heroTag: "btn-$index",
            onPressed: photoUrl == null ? onAddPhoto : onRemovePhoto,
            backgroundColor:
                photoUrl == null ? AppColors.primary : Colors.grey[700],
            mini: true,
            child: Icon(
              photoUrl == null ? Icons.add : Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

    return photoUrl == null
        ? DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            dashPattern: const [8, 4],
            strokeWidth: 1.5,
            child: child,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: child,
          );
  }
}

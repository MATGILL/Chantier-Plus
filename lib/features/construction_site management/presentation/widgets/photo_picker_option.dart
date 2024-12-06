import 'package:flutter/material.dart';

class PhotoPickerOptions extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  const PhotoPickerOptions({
    super.key,
    required this.onCameraSelected,
    required this.onGallerySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choisissez une option',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 36),
                onPressed: onCameraSelected,
              ),
              IconButton(
                icon: const Icon(Icons.photo_library, size: 36),
                onPressed: onGallerySelected,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

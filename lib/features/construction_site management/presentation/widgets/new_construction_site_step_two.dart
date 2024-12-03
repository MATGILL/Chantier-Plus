import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/new_construction_site_bloc/new_construction_site_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/photo_card.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/photo_picker_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewConstructionSiteStepTwo extends StatelessWidget {
  final List<XFile> selectedPhotos;
  const NewConstructionSiteStepTwo({super.key, required this.selectedPhotos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 13.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 5, // Nombre de cartes
        itemBuilder: (context, index) {
          return PhotoCard(
            index: index,
            photoUrl: index < selectedPhotos.length
                ? selectedPhotos[index].path
                : null,
            onAddPhoto: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (innerContext) => PhotoPickerOptions(
                  onCameraSelected: () {
                    context
                        .read<NewConstructionBloc>()
                        .add(PickPhotoFromCamera());
                  },
                  onGallerySelected: () {
                    context
                        .read<NewConstructionBloc>()
                        .add(PickPhotoFromGallery());
                  },
                ),
              );
            },
            onRemovePhoto: () {
              context
                  .read<NewConstructionBloc>()
                  .add(PhotoRemoved(selectedPhotos[index].path));
            },
          );
        },
      ),
    );
  }
}

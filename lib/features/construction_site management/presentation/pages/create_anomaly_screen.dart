import 'dart:io';

import 'package:chantier_plus/common/widgets/inputs/cutom_text_form_field.dart';
import 'package:chantier_plus/common/widgets/simple_app_bar.dart';
import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/createAnomalyBloc/create_anomaly_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAnomalyScreen extends StatelessWidget {
  const CreateAnomalyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateAnomalyBloc(),
      child: CreateAnomalyPage(),
    );
  }
}

class CreateAnomalyPage extends StatelessWidget {
  const CreateAnomalyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SimpleAppBar(),
        body: BlocBuilder<CreateAnomalyBloc, CreateAnomalyState>(
            builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              //TITLE
              const _TitleWidget(),
              //Inputs
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 16, right: 16),
                child: Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: CustomTextFormField(
                          labelText: "Titre",
                          hintText: "Titre du signalement",
                          controller: TextEditingController()),
                    ),
                    CustomTextFormField(
                      labelText: "Description",
                      hintText: "Description du signalement",
                      controller: TextEditingController(),
                      isLongText: true,
                    )
                  ],
                )),
              ),
              //TITLE PHOTO SECTION
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: Text(
                  "Ajouter des photos :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.2,
                  ),
                ),
              ),
              //PHOTO SELECTION GRID
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
                      photoUrl: index < state.selectedPhotos.length
                          ? state.selectedPhotos[index].path
                          : null,
                      onAddPhoto: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (innerContext) => PhotoPickerOptions(
                            onCameraSelected: () {
                              context
                                  .read<CreateAnomalyBloc>()
                                  .add(PickPhotoFromCamera());
                            },
                            onGallerySelected: () {
                              context
                                  .read<CreateAnomalyBloc>()
                                  .add(PickPhotoFromGallery());
                            },
                          ),
                        );
                      },
                      onRemovePhoto: () {
                        context.read<CreateAnomalyBloc>().add(
                            PhotoRemoved(state.selectedPhotos[index].path));
                      },
                    );
                  },
                ),
              )
            ],
          );
        }));
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Signaler un\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                height: 1.2, // Meilleure lisibilité
              ),
            ),
            TextSpan(
              text: 'problème',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: AppColors.error,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class PhotoCard extends StatelessWidget {
  final String? photoUrl;
  final VoidCallback onAddPhoto;
  final VoidCallback onRemovePhoto;

  const PhotoCard({
    super.key,
    this.photoUrl,
    required this.onAddPhoto,
    required this.onRemovePhoto,
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

class PhotoPickerOptions extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  const PhotoPickerOptions({
    Key? key,
    required this.onCameraSelected,
    required this.onGallerySelected,
  }) : super(key: key);

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

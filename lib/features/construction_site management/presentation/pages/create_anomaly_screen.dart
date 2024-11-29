import 'package:chantier_plus/common/widgets/simple_app_bar.dart';
import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/createAnomalyBloc/create_anomaly_bloc.dart';
import 'package:chantier_plus/common/widgets/inputs/custom_text_field.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/photo_card.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/photo_picker_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAnomalyScreen extends StatelessWidget {
  final String constructionSiteId;
  const CreateAnomalyScreen({super.key, required this.constructionSiteId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateAnomalyBloc(constructionSiteId: constructionSiteId),
      child: const CreateAnomalyPage(),
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
          if (state.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
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
                      child: CustomTextField(
                        labelText: "Titre",
                        hintText: "Titre du signalement",
                        erroText: state.titleError,
                        onChanged: (value) {
                          context
                              .read<CreateAnomalyBloc>()
                              .add(TitleChanged(value));
                        },
                      ),
                    ),
                    CustomTextField(
                      labelText: "Description",
                      hintText: "Description du signalement",
                      isLongText: true,
                      erroText: state.descriptionError,
                      onChanged: (value) {
                        context
                            .read<CreateAnomalyBloc>()
                            .add(DescriptionChanged(value));
                      },
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
                      index: index,
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
              ),
              Center(
                child: ElevatedButton(
                  onPressed: state.isSubmitting
                      ? null // Désactiver le bouton si isSubmitting est true
                      : () {
                          context
                              .read<CreateAnomalyBloc>()
                              .add(SubmitAnomaly());
                        },
                  child: state.isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white, // Couleur du loader
                            strokeWidth: 2, // Épaisseur du loader
                          ),
                        )
                      : const Text("Envoyer"),
                ),
              ),
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

import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/new_construction_site_bloc/new_construction_site_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/chef_selection.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/new_construction_site_step_one.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/new_construction_site_step_three.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/new_construction_site_step_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewConstructionSiteScreen extends StatelessWidget {
  const NewConstructionSiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewConstructionBloc()..add(FetchAllChef()),
      child: const NewConstructionSitePage(),
    );
  }
}

class NewConstructionSitePage extends StatelessWidget {
  const NewConstructionSitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Créer un chantier"),
        ),
        body: BlocBuilder<NewConstructionBloc, NewConstructionState>(
            builder: (context, state) {
          if (state.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
          if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Erreur while creating the constructionSIte")),
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Titre pour l'Étape 1

                // Etape 1 : Informations du chantier
                NewConstructionSiteStepOne(),
                ChefSelection(),

                // Titre pour l'Étape 2

                NewConstructionSiteStepTwo(),

                // // Titre pour l'Étape 3

                // // Etape 3 : Ressources
                const NewConstructionSiteStepThree(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: ElevatedButton(
                    onPressed: state.isSubmitting
                        ? null // Désactiver le bouton si isSubmitting est true
                        : () {
                            context
                                .read<NewConstructionBloc>()
                                .add(SubmitConstructionSite());
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
            ),
          );
        }));
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        textAlign: TextAlign.left, // Ajout de l'alignement à gauche
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

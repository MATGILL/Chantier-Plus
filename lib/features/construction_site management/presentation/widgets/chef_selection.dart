import 'package:chantier_plus/common/widgets/inputs/cutom_text_form_field.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/new_construction_site_bloc/new_construction_site_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ChefSelection extends StatelessWidget {
  const ChefSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewConstructionBloc, NewConstructionState>(
      builder: (context, state) {
        // Vérifier si l'état contient une liste d'utilisateurs
        List<UserEntity> users = state.chefs; // Liste des utilisateurs

        // Créer un controller pour le champ de texte
        TextEditingController controller = TextEditingController();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TypeAheadField<UserEntity>(
            builder: (context, controller, focusNode) {
              if (state.selectedChef != null) {
                state.selectedChef!.fullName!;
              }
              return CustomTextFormField(
                errorMessage: state.errorChef,
                controller: controller,
                focusNode: focusNode,
                hintText: "Sélectionner le chef du chantier",
                labelText: "Chef de chantier",
              );
            },
            // Utilisation de textFieldBuilder au lieu de textFieldConfiguration
            suggestionsCallback: (pattern) {
              // Conversion de l'Iterable en List pour le retour
              return users
                  .where((user) => user.fullName!
                      .toLowerCase()
                      .contains(pattern.toLowerCase()))
                  .toList();
            },
            itemBuilder: (context, UserEntity suggestion) {
              return ListTile(
                title: Text(suggestion.fullName!),
              );
            },
            // Ajout du paramètre onSelected pour gérer la sélection
            onSelected: (UserEntity chef) {
              // Mettre à jour le texte du contrôleur avec le nom du chef sélectionné

              // Vous pouvez maintenant ajouter l'événement au bloc
              context.read<NewConstructionBloc>().add(SelectChef(chef));
            },
          ),
        );
      },
    );
  }
}

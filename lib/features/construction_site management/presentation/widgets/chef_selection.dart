import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/new_construction_site_bloc/new_construction_site_bloc.dart';

class ChefSelection extends StatelessWidget {
  const ChefSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewConstructionBloc, NewConstructionState>(
      builder: (context, state) {
        // Liste des utilisateurs (chefs)
        final List<UserEntity> users = state.chefs;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chef de chantier",
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<UserEntity>(
                value: state.selectedChef, // Chef sélectionné actuellement
                isExpanded: true,
                hint: const Text("Sélectionner le chef du chantier"),
                items: users.map((UserEntity user) {
                  return DropdownMenuItem<UserEntity>(
                    value: user,
                    child: Text(user.fullName ?? ""),
                  );
                }).toList(),
                onChanged: (UserEntity? selectedChef) {
                  if (selectedChef != null) {
                    // Ajouter un événement au bloc avec le chef sélectionné
                    context
                        .read<NewConstructionBloc>()
                        .add(SelectChef(selectedChef));
                  }
                },
                decoration: InputDecoration(
                  errorText: state.errorChef, // Affiche l'erreur si nécessaire
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

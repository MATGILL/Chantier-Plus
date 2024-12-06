import 'package:chantier_plus/common/widgets/inputs/custom_text_field.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/bloc/new_supply_bloc/new_supply_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSupply extends StatelessWidget {
  const CreateSupply({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateSupplyBloc(),
      child: BlocBuilder<CreateSupplyBloc, CreateSupplyState>(
          builder: (context, state) {
        if (state.status == SupplyStateStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        }
        if (state.status == SupplyStateStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error while creating the resource.")),
          );
        }
        return Column(
          children: [
            // Champ pour la marque
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                labelText: "Type",
                hintText: "Type de la fourniture",
                onChanged: (type) {
                  context.read<CreateSupplyBloc>().add(TypeChanged(type));
                },
                erroText: state.typeError,
              ),
            ),
            // Champ pour le modèle
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                labelText: "Nom",
                hintText: "Nom de la fourniture",
                onChanged: (name) {
                  context.read<CreateSupplyBloc>().add(NameChanged(name));
                },
                erroText: state.nameError,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: state.status == SupplyStateStatus.loading
                      ? null // Désactiver le bouton si isSubmitting est true
                      : () {
                          context
                              .read<CreateSupplyBloc>()
                              .add(const SubmitSupply());
                        },
                  child: state.status == SupplyStateStatus.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white, // Couleur du loader
                            strokeWidth: 2, // Épaisseur du loader
                          ),
                        )
                      : const Text("Créer"),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:chantier_plus/common/widgets/inputs/custom_text_field.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/bloc/new_vehicle_bloc/new_vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateVehicle extends StatelessWidget {
  const CreateVehicle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateVehicleBloc(),
      child: BlocBuilder<CreateVehicleBloc, CreateVehicleState>(
          builder: (context, state) {
        if (state.status == VehicleStateStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        }
        if (state.status == VehicleStateStatus.error) {
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
                labelText: "Marque",
                hintText: "marque du véhicule",
                onChanged: (brand) {
                  context.read<CreateVehicleBloc>().add(BrandChanged(brand));
                },
                erroText: state.brandError,
              ),
            ),
            // Champ pour le modèle
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                labelText: "Modèle",
                hintText: "modèle du véhicule",
                onChanged: (model) {
                  context.read<CreateVehicleBloc>().add(ModelChanged(model));
                },
                erroText: state.modelError,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: state.status == VehicleStateStatus.loading
                      ? null // Désactiver le bouton si isSubmitting est true
                      : () {
                          context
                              .read<CreateVehicleBloc>()
                              .add(const SubmitVehicle());
                        },
                  child: state.status == VehicleStateStatus.loading
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

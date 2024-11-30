import 'package:chantier_plus/common/widgets/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';

class CreateSupply extends StatelessWidget {
  final ValueChanged<String>? onBrandChanged;
  final ValueChanged<String>? onModelChanged;

  const CreateSupply({super.key, this.onBrandChanged, this.onModelChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Champ pour la marque
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            labelText: "Type",
            hintText: "Type",
            onChanged: onBrandChanged,
            erroText: null,
          ),
        ),
        // Champ pour le modèle
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            labelText: "Quantitée",
            hintText: "Quantitée de matériaux",
            onChanged: onModelChanged,
            erroText: null,
            isDigit: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: ElevatedButton(
              // onPressed: state.isSubmitting
              //     ? null // Désactiver le bouton si isSubmitting est true
              //     : () {
              //         context.read<CreateAnomalyBloc>().add(SubmitAnomaly());
              //       },
              // child: state.isSubmitting
              //     ? const SizedBox(
              //         width: 20,
              //         height: 20,
              //         child: CircularProgressIndicator(
              //           color: Colors.white, // Couleur du loader
              //           strokeWidth: 2, // Épaisseur du loader
              //         ),
              //       )
              //     : const Text("Envoyer"),
              onPressed: () {},
              child: const Text("Créer"),
            ),
          ),
        ),
      ],
    );
  }
}

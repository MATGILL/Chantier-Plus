import 'package:chantier_plus/common/widgets/inputs/custom_date_picker.dart';
import 'package:chantier_plus/common/widgets/inputs/custom_drop_down_menu.dart';
import 'package:chantier_plus/common/widgets/inputs/custom_text_field.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/new_construction_site_bloc/new_construction_site_bloc.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewConstructionSiteStepOne extends StatelessWidget {
  const NewConstructionSiteStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewConstructionBloc, NewConstructionState>(
        builder: (context, state) {
      return Column(
        children: [
          // Nom du chantier
          CustomTextField(
            labelText: "Nom",
            hintText: "Nom du chantier",
            erroText: state.nameError,
            onChanged: (name) {
              context.read<NewConstructionBloc>().add(NameChanged(name));
            },
          ),
          const SizedBox(height: 16),

          // Date de début
          CustomDatePicker(
            labelText: "Date du début",
            hintText: "Sélectionner une date",
            errorText: state.errorDate,
            onDateSelected: (date) {
              context.read<NewConstructionBloc>().add(DateChanged(date));
            },
          ),

          const SizedBox(height: 16),

          // Matin ou Soir
          CustomDropdownMenu<HalfDay>(
            labelText: "Type",
            hintText: "type de ressource",
            value: state.constructionSite.halfDayStarting,
            items: HalfDay.values,
            onChanged: (value) {
              context.read<NewConstructionBloc>().add(HalfDayChanged(value!));
            },
          ),
          const SizedBox(height: 16),

          // Nombre de demi-journées
          CustomTextField(
            labelText: "Demi-journées",
            hintText: "Nombre de demi-journées",
            isDigit: true,
            erroText: state.numberHalfDayError,
            onChanged: (durationInHalfDay) {
              final durationInt = (durationInHalfDay.isNotEmpty &&
                      int.tryParse(durationInHalfDay) != null)
                  ? int.parse(durationInHalfDay)
                  : 0;

              context
                  .read<NewConstructionBloc>()
                  .add(NumberHalfDayChanged(durationInt));
            },
          ),

          const SizedBox(height: 16),

          // Adresse
          CustomTextField(
            labelText: "Adresse",
            hintText: "Adresse du chantier",
            onChanged: (location) {
              //TODO implement
            },
          ),
          const SizedBox(height: 16),

          // Contact du client
          CustomTextField(
            labelText: "Contact",
            hintText: "Contact téléphonique",
            isDigit: true,
            erroText: state.contactError,
            onChanged: (contact) {
              context.read<NewConstructionBloc>().add(ContactChanged(contact));
            },
          ),
        ],
      );
    });
  }
}

import 'package:chantier_plus/common/widgets/inputs/custom_drop_down_menu.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/resource_type.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/bloc/new_resource_bloc/new_resource_bloc.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/widget/create_supply.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/widget/create_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateResourceScreen extends StatelessWidget {
  const CreateResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateResourceBloc(),
      child: const CreateResourcePage(),
    );
  }
}

class CreateResourcePage extends StatelessWidget {
  const CreateResourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateResourceBloc, ResourceState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Nouvelle ressource"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: CustomDropdownMenu<ResourceType>(
                    labelText: "Type",
                    value: state.resourceType,
                    hintText: "type de ressource",
                    items: ResourceType.values,
                    onChanged: (value) {
                      context
                          .read<CreateResourceBloc>()
                          .add(SelectResourceTypeEvent(resourceType: value!));
                    },
                  ),
                ),
                if (state.resourceTypeSelected &&
                    state.resourceType == ResourceType.vehicle)
                  const CreateVehicle(),
                if (state.resourceTypeSelected &&
                    state.resourceType == ResourceType.supply)
                  const CreateSupply()
              ],
            ),
          ));
    });
  }
}

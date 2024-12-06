import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/new_construction_site_bloc/new_construction_site_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/new_construction_site_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewConstructionSiteStepThree extends StatelessWidget {
  const NewConstructionSiteStepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2, // Exemple : Véhicules, Matériels, Autres
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Ajouter des ressources au chantier"),
          TabBar(
            tabs: [
              Tab(text: "Véhicules"),
              Tab(text: "Matériels"),
            ],
          ),
          SizedBox(
            height: 200, // Vous pouvez ajuster la hauteur
            child: TabBarView(
              children: [
                VehicleChoiceListScreen(),
                SupplyChoiceListScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleChoiceListScreen extends StatelessWidget {
  const VehicleChoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewConstructionBloc, NewConstructionState>(
      builder: (context, state) {
        if (state.status == NewConstructionStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == NewConstructionStatus.error) {
          return const Center(child: Text('Failed to load vehicles.'));
        } else if (state.vehicles.isEmpty) {
          return const Center(child: Text('No vehicles available.'));
        } else {
          return ListView.builder(
            itemCount: state.vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = state.vehicles[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
                child: Card(
                  color: AppColors.lightBackground,
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      // Trait bleu sur la gauche
                      Container(
                        width: 5,
                        height: 80,
                        color: state.constructionSite.vehicles.contains(vehicle)
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(vehicle.brand),
                          subtitle: Text(vehicle.model),
                          trailing: IconButton(
                              onPressed: () {
                                if (state.constructionSite.vehicles
                                    .contains(vehicle)) {
                                  context
                                      .read<NewConstructionBloc>()
                                      .add(RemoveVehicle(vehicle));
                                } else {
                                  context
                                      .read<NewConstructionBloc>()
                                      .add(SelectVehicle(vehicle));
                                }
                              },
                              icon: state.constructionSite.vehicles
                                      .contains(vehicle)
                                  ? const Icon(Icons.remove)
                                  : const Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class SupplyChoiceListScreen extends StatelessWidget {
  const SupplyChoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewConstructionBloc, NewConstructionState>(
      builder: (context, state) {
        if (state.status == NewConstructionStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == NewConstructionStatus.error) {
          return const Center(child: Text('Failed to load vehicles.'));
        } else if (state.supplies.isEmpty) {
          return const Center(child: Text('No vehicles available.'));
        } else {
          return ListView.builder(
            itemCount: state.supplies.length,
            itemBuilder: (context, index) {
              final supply = state.supplies[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
                child: Card(
                  color: AppColors.lightBackground,
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      // Trait bleu sur la gauche
                      Container(
                        width: 5,
                        height: 80,
                        color: state.constructionSite.supplies.contains(supply)
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(supply.name),
                          subtitle: Text(supply.type),
                          trailing: IconButton(
                              onPressed: () {
                                if (state.constructionSite.supplies
                                    .contains(supply)) {
                                  context
                                      .read<NewConstructionBloc>()
                                      .add(RemoveSupply(supply));
                                } else {
                                  context
                                      .read<NewConstructionBloc>()
                                      .add(SelectSupply(supply));
                                }
                              },
                              icon: state.constructionSite.supplies
                                      .contains(supply)
                                  ? const Icon(Icons.remove)
                                  : const Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

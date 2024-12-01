import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/bloc/vehicle_list_bloc/vehicle_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleListWidget extends StatelessWidget {
  const VehicleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehicleListBloc()..add(FetchVehicles()),
      child: BlocBuilder<VehicleListBloc, VehicleListState>(
        builder: (context, state) {
          if (state.status == VehicleListStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == VehicleListStateStatus.error) {
            return const Center(child: Text('Failed to load vehicles.'));
          } else if (state.vehicles.isEmpty) {
            return const Center(child: Text('No vehicles available.'));
          } else {
            return RefreshIndicator(
              color: Theme.of(context).progressIndicatorTheme.color,
              onRefresh: () async {
                context.read<VehicleListBloc>().add(FetchVehicles());
              },
              child: ListView.builder(
                itemCount: state.vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = state.vehicles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 10),
                    child: Card(
                      color: AppColors.lightBackground,
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          // Trait bleu sur la gauche
                          Container(
                            width: 5,
                            height: 80,
                            color: AppColors.primary,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(vehicle.brand),
                              subtitle: Text(vehicle.model),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

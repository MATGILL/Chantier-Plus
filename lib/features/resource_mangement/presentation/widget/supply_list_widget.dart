import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:chantier_plus/features/resource_mangement/presentation/bloc/supply_list_bloc/supply_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupplyListWidget extends StatelessWidget {
  const SupplyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SupplyListBloc()..add(FetchVSupplies()),
      child: BlocBuilder<SupplyListBloc, SupplyListState>(
        builder: (context, state) {
          if (state.status == SupplyListStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == SupplyListStateStatus.error) {
            return const Center(child: Text('Failed to load vehicles.'));
          } else if (state.supplies.isEmpty) {
            return const Center(child: Text('No vehicles available.'));
          } else {
            return RefreshIndicator(
              color: Theme.of(context).progressIndicatorTheme.color,
              onRefresh: () async {
                context.read<SupplyListBloc>().add(FetchVSupplies());
              },
              child: ListView.builder(
                itemCount: state.supplies.length,
                itemBuilder: (context, index) {
                  final vehicle = state.supplies[index];
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
                              title: Text(vehicle.name),
                              subtitle: Text(vehicle.type),
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

import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';
import 'package:chantier_plus/features/resource_mangement/domain/service/resource_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vehicle_list_event.dart';
part 'vehicle_list_state.dart';

class VehicleListBloc extends Bloc<VehicleListEvent, VehicleListState> {
  final ResourceService _service = serviceLocator<ResourceService>();

  VehicleListBloc()
      : super(const VehicleListState(status: VehicleListStateStatus.initial)) {
    on<FetchVehicles>(_onFetchConstructionSites);
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _onFetchConstructionSites(
    FetchVehicles event,
    Emitter<VehicleListState> emit,
  ) async {
    emit(const VehicleListState(status: VehicleListStateStatus.loading));

    // Appel au service pour récupérer les données
    final result = await _service.getAllVehicle();

    // Gestion du succès ou de l'échec
    if (result.content != null) {
      emit(VehicleListState(
        status: VehicleListStateStatus.success,
        vehicles: result.content!,
      ));
    } else {
      emit(const VehicleListState(
        status: VehicleListStateStatus.error,
        vehicles: [],
      ));
    }
  }
}

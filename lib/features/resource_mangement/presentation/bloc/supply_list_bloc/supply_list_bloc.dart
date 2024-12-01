import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/resource_mangement/domain/service/resource_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/supply.dart';

part 'supply_list_event.dart';
part 'supply_list_state.dart';

class SupplyListBloc extends Bloc<SupplyListEvent, SupplyListState> {
  final ResourceService _service = serviceLocator<ResourceService>();

  SupplyListBloc()
      : super(const SupplyListState(status: SupplyListStateStatus.initial)) {
    on<FetchVSupplies>(_onFetchSupplies);
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _onFetchSupplies(
    FetchVSupplies event,
    Emitter<SupplyListState> emit,
  ) async {
    emit(const SupplyListState(status: SupplyListStateStatus.loading));

    // Appel au service pour récupérer les données
    final result = await _service.getAllSupply();

    // Gestion du succès ou de l'échec
    if (result.content != null) {
      emit(SupplyListState(
        status: SupplyListStateStatus.success,
        supplies: result.content!,
      ));
    } else {
      emit(const SupplyListState(
        status: SupplyListStateStatus.error,
        supplies: [],
      ));
    }
  }
}

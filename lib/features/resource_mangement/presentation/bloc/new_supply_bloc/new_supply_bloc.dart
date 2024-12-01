import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/supply.dart';
import 'package:chantier_plus/features/resource_mangement/domain/service/resource_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_supply_event.dart';
part 'new_supply_state.dart';

class CreateSupplyBloc extends Bloc<CreateSupplyEvent, CreateSupplyState> {
  final ResourceService _resourceService;

  CreateSupplyBloc()
      : _resourceService = serviceLocator<ResourceService>(), //TODO change !!
        super(const CreateSupplyState(
          supply: Supply(
            id: '',
            type: '',
            name: '',
            unavailabilities: [],
          ),
        )) {
    on<TypeChanged>(_onTypeChanged);
    on<NameChanged>(_onNameChanged);
    on<SubmitSupply>(_onSubmit);
  }

  // Gestionnaire d'événement pour BrandChanged
  Future<void> _onTypeChanged(
    TypeChanged event,
    Emitter<CreateSupplyState> emit,
  ) async {
    emit(state.copyWith(
      supply: state.supply!.copyWith(type: event.type),
    ));
  }

  // Gestionnaire d'événement pour BrandChanged
  Future<void> _onNameChanged(
    NameChanged event,
    Emitter<CreateSupplyState> emit,
  ) async {
    emit(state.copyWith(
      supply: state.supply!.copyWith(name: event.name),
    ));
  }

  // Gestionnaire d'événement pour SubmitVehicle
  Future<void> _onSubmit(
    SubmitSupply event,
    Emitter<CreateSupplyState> emit,
  ) async {
    final typeError = _validateType(state.supply!.type);
    final nameError = _validateName(state.supply!.name);

    if (typeError != null || nameError != null) {
      emit(state.copyWith(
        typeError: typeError,
        nameError: nameError,
      ));
      return;
    }

    emit(state.copyWith(status: SupplyStateStatus.loading));

    try {
      // Appel Firebase ou autre service
      var result = await _resourceService.createSupply(state.supply!);

      if (result.error.isEmpty) {
        emit(state.copyWith(status: SupplyStateStatus.success));
      } else {
        emit(state.copyWith(status: SupplyStateStatus.error));
      }
    } catch (_) {
      emit(state.copyWith(status: SupplyStateStatus.error));
    }
  }

  ///
  /// Validation
  ///

  String? _validateType(String type) {
    if (type.isEmpty) {
      return "Le type est requise.";
    }
    return null;
  }

  String? _validateName(String name) {
    if (name.isEmpty) {
      return "Le nom est requise.";
    }
    return null;
  }
}

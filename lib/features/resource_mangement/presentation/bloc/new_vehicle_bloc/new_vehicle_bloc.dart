import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';
import 'package:chantier_plus/features/resource_mangement/domain/service/resource_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_vehicle_event.dart';
part 'new_vehicle_state.dart';

class CreateVehicleBloc extends Bloc<CreateVehicleEvent, CreateVehicleState> {
  final ResourceService _resourceService;

  CreateVehicleBloc()
      : _resourceService = serviceLocator<ResourceService>(),
        super(const CreateVehicleState(
          vehicule: Vehicle(
            id: '',
            brand: '',
            model: '',
            unavailabilities: [],
          ),
        )) {
    on<BrandChanged>(_onBrandChanged);
    on<ModelChanged>(_onModelChanged);
    on<SubmitVehicle>(_onSubmit);
  }

  // Gestionnaire d'événement pour BrandChanged
  Future<void> _onBrandChanged(
    BrandChanged event,
    Emitter<CreateVehicleState> emit,
  ) async {
    emit(state.copyWith(
      vehicule: state.vehicule!.copyWith(brand: event.brand),
    ));
  }

  // Gestionnaire d'événement pour ModelChanged
  Future<void> _onModelChanged(
    ModelChanged event,
    Emitter<CreateVehicleState> emit,
  ) async {
    emit(state.copyWith(
      vehicule: state.vehicule!.copyWith(model: event.model),
    ));
  }

  // Gestionnaire d'événement pour SubmitVehicle
  Future<void> _onSubmit(
    SubmitVehicle event,
    Emitter<CreateVehicleState> emit,
  ) async {
    final brandError = _validateBrand(state.vehicule!.brand);
    final modelError = _validateModel(state.vehicule!.model);

    if (brandError != null || modelError != null) {
      emit(state.copyWith(
        brandError: brandError,
        modelError: modelError,
      ));
      return;
    }

    emit(state.copyWith(status: VehicleStateStatus.loading));

    try {
      // Appel Firebase ou autre service
      var result = await _resourceService.createVehicle(state.vehicule!);

      if (result.error.isEmpty) {
        emit(state.copyWith(status: VehicleStateStatus.success));
      } else {
        emit(state.copyWith(status: VehicleStateStatus.error));
      }
    } catch (_) {
      emit(state.copyWith(status: VehicleStateStatus.error));
    }
  }

  ///
  /// Validation
  ///

  String? _validateBrand(String brand) {
    if (brand.isEmpty) {
      return "La marque est requise.";
    }
    return null;
  }

  String? _validateModel(String model) {
    if (model.isEmpty) {
      return "Le modèle est requis.";
    }
    return null;
  }
}

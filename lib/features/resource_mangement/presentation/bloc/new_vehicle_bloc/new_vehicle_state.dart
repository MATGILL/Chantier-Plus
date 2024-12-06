part of 'new_vehicle_bloc.dart';

enum VehicleStateStatus { initial, loading, success, error }

class CreateVehicleState extends Equatable {
  final VehicleStateStatus status;
  final Vehicle? vehicule;
  final String? error;
  final String? brandError; // Ajout du champ pour l'erreur de la marque
  final String? modelError; // Ajout du champ pour l'erreur du modèle

  const CreateVehicleState({
    this.status = VehicleStateStatus.initial,
    this.vehicule,
    this.error,
    this.brandError,
    this.modelError,
  });

  @override
  List<Object?> get props => [
        status,
        vehicule ?? '',
        error ?? '',
        brandError ?? '',
        modelError ?? '',
      ];

  CreateVehicleState copyWith({
    VehicleStateStatus? status,
    Vehicle? vehicule,
    String? error,
    String? brandError,
    String? modelError,
  }) {
    return CreateVehicleState(
      status: status ?? this.status,
      vehicule: vehicule ?? this.vehicule,
      error: error ?? this.error,
      brandError: brandError ?? this.brandError,
      modelError: modelError ?? this.modelError,
    );
  }
}

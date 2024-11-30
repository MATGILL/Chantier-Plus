part of 'new_vehicle_bloc.dart';

abstract class CreateVehicleEvent extends Equatable {
  const CreateVehicleEvent();
}

class BrandChanged extends CreateVehicleEvent {
  final String brand;

  const BrandChanged(this.brand);

  @override
  List<Object?> get props => [brand];
}

class ModelChanged extends CreateVehicleEvent {
  final String model;

  const ModelChanged(this.model);

  @override
  List<Object?> get props => [model];
}

class SubmitVehicle extends CreateVehicleEvent {
  const SubmitVehicle();

  @override
  List<Object?> get props => [];
}

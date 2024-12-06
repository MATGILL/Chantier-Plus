part of 'vehicle_list_bloc.dart';

enum VehicleListStateStatus { initial, loading, success, error }

final class VehicleListState extends Equatable {
  final VehicleListStateStatus status;
  final List<Vehicle> vehicles;

  const VehicleListState({
    this.status = VehicleListStateStatus.initial,
    this.vehicles = const [],
  });

  VehicleListState copyWith({
    VehicleListStateStatus? status,
    List<Vehicle>? vehicles,
  }) {
    return VehicleListState(
      status: status ?? this.status,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  @override
  List<Object?> get props => [
        status,
        vehicles,
      ];
}

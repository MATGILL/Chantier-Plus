import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/supply.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';
import 'package:chantier_plus/features/resource_mangement/domain/repository/ressource_repository.dart';

class ResourceService {
  final RessourceRepository _repository;

  ResourceService({required RessourceRepository repository})
      : _repository = repository;

  Future<ServiceResult<String>> createVehicle(Vehicle vehicle) async {
    return await _repository.createVehicle(vehicle);
  }

  Future<ServiceResult<String>> createSupply(Supply supply) async {
    return await _repository.createSupply(supply);
  }

  Future<ServiceResult<List<Vehicle>>> getAllVehicle() async {
    return await _repository.getAllVehicle();
  }

  Future<ServiceResult<List<Supply>>> getAllSupply() async {
    return await _repository.getAllSupply();
  }
}

import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/supply.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';

abstract class RessourceRepository {
  Future<ServiceResult<List<Vehicle>>> getAvailableVehicleForPeriod(
      HalfDay halfDayBeginning, DateTime startingDate, int durationInDays);

  Future<ServiceResult<List<Supply>>> getAvailableSupplyrPeriod(
      HalfDay halfDayBeginning, DateTime startingDate, int durationInDays);

  Future<ServiceResult<String>> createVehicle(Vehicle vehicle);

  Future<ServiceResult<String>> createSupply(Supply supply);
}

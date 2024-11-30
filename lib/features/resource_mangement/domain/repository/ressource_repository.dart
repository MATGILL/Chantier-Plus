import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';

abstract class RessourceRepository {
  Future<ServiceResult<List<Vehicle>>> getAvailableVehicleForPeriod(
      HalfDay halfDayBeginning, DateTime startingDate, int durationInDays);
}

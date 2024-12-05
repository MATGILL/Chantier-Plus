import 'package:chantier_plus/features/construction_site%20management/data/dto/construction_site_light.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';

class ConstructionSiteMapper {
  static ConstructionSite fromDto(ConstructionSiteLightDto data) {
    //Build a list of anomaly only with id
    var anomalies = data.anomalies
        .map((anomaliesId) => Anomaly.empty().copyWith(id: anomaliesId))
        .toList();

    return ConstructionSite(
        id: data.id,
        object: data.object,
        durationInHalfDays: data.durationInHalfDays,
        startingDate: data.startingDate,
        halfDayStarting: data.halfDayStarting,
        location: data.location,
        geoPoint: data.geoPoint,
        clientContact: data.clientContact,
        status: StatusExtension.fromString(data.status),
        photos: data.photos,
        anomalyNumber: anomalies.length,
        anomalies: anomalies);
  }

  static Map<String, dynamic> toFirestore(ConstructionSite site) {
    return {
      'id': site.id,
      'object': site.object,
      'startingDate': site.startingDate != null
          ? site.startingDate!.toIso8601String()
          : DateTime.now(),
      'durationInHalfDays': site.durationInHalfDays,
      'location': site.location,
      'geoPoint': site.geoPoint,
      'clientContact': site.clientContact,
      'status': site.status.toString().split('.').last,
      'photos': site.photos,
      'anomalies': site.anomalies.map((anomalu) => anomalu.id).toList(),
      'vehicles': site.vehicles.map((vehicle) => vehicle.id).toList(),
      'supplies': site.vehicles.map((suply) => suply.id).toList()
    };
  }
}

import 'package:chantier_plus/features/construction_site%20management/data/dto/construction_site_light.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';

class ConstructionSiteMapper {
  static ConstructionSite fromDto(ConstructionSiteLightDto data) {
    var anomalies = data.anomalies
        .map((anomaliesId) => Anomaly.empty().copyWith(id: anomaliesId))
        .toList();
    return ConstructionSite(
        id: data.id,
        object: data.object,
        startingDate: data.startingDate,
        durationInHalfDays: data.durationInHalfDays,
        location: data.location,
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
      'startingDate': site.startingDate.toIso8601String(),
      'durationInHalfDays': site.durationInHalfDays,
      'location': site.location,
      'clientContact': site.clientContact,
      'status': site.status.toString().split('.').last,
      'photos': site.photos,
      'anomalies': site.anomalies.map((anomalu) => anomalu.id).toList()
      // Autres transformations nécessaires
    };
  }
}

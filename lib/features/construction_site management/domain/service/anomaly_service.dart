import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/anomaly_repository.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/construction_site_repository.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/photo_repository.dart';
import 'package:image_picker/image_picker.dart';

class AnomalyService {
  final AnomalyRepository _anomalyRepository;
  final ConstructionSiteRepository _constructionSiteRepository;
  final PhotoRepository _photoRepository;

  AnomalyService(
      {required AnomalyRepository anomalyRepository,
      required PhotoRepository photoRepository,
      required ConstructionSiteRepository constructionSiteRepository})
      : _anomalyRepository = anomalyRepository,
        _constructionSiteRepository = constructionSiteRepository,
        _photoRepository = photoRepository;

  Future<ServiceResult<String>> createAnomaly(
      Anomaly anomaly, List<XFile> photos) async {
    // Création de l'anomalie
    var createAnomalyResult = await _anomalyRepository.createAnomaly(anomaly);
    if (createAnomalyResult.error.isNotEmpty) {
      return ServiceResult(error: "Unable to create anomaly");
    }

    var anomalyId = createAnomalyResult.content;

    // Upload des photos
    if (photos.isNotEmpty) {
      var photoResult =
          await _photoRepository.uploadAnomalyPhotos(anomalyId!, photos);
      if (photoResult.error.isNotEmpty) {
        return ServiceResult(error: "Unable to upload photo.");
      }

      // Ajout des photos à l'anomalie
      await _anomalyRepository.addPhotosToAnomaly(
          anomalyId, photoResult.content!);
    }

    // Ajout de l'anomalie au chantier
    var constructionUpdateResult = await _constructionSiteRepository
        .addAnomalyToConstructionSite(anomaly.constructionSiteId, anomalyId!);
    if (constructionUpdateResult.error.isNotEmpty) {
      return ServiceResult(
          error:
              "Unable to add anomaly to constructionSite ${anomaly.constructionSiteId}");
    }

    return Future.value(ServiceResult(content: anomalyId));
  }

  // Méthode pour récupérer les anomalies d'un chantier donné
  Future<ServiceResult<List<Anomaly>>> getAnomalyForConstructionSite(
      String siteId) async {
    try {
      // Récupère les anomalies pour le chantier spécifié
      var anomaliesResult =
          await _anomalyRepository.getAnomalyForConstructionSite(siteId);

      if (anomaliesResult.error.isNotEmpty) {
        return ServiceResult(error: "Unable to fetch anomalies");
      }

      return anomaliesResult;
    } catch (e) {
      return ServiceResult(error: "Unable to fetch anomalies: ${e.toString()}");
    }
  }
}

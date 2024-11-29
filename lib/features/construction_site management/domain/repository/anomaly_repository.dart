import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';

abstract class AnomalyRepository {
  /// Creates a new anomaly and associates it with a specific construction site.
  ///
  /// This method accepts an [Anomaly] object that contains all the necessary details about the
  /// anomaly, such as title, description, photos, and author. The [constructionSiteId] is used
  /// to link the anomaly to the correct construction site in the repository (e.g., in a Firestore collection).
  ///
  /// **Parameters:**
  /// - [anomaly] (Anomaly): The [Anomaly] object that holds the details of the anomaly to be created.
  /// - [constructionSiteId] (String): The unique identifier of the construction site to associate the anomaly with.
  ///
  /// **Returns:**
  /// - [Future<String>]: A [Future] that resolves to a string representing the unique identifier of the created anomaly.
  ///   This could be the ID of the newly created anomaly, which is useful for further operations.
  Future<ServiceResult<String>> createAnomaly(Anomaly anomaly);

  Future<ServiceResult<String>> addPhotosToAnomaly(
      String anomalyId, List<String> photos);

  //TODO implement the rest
}

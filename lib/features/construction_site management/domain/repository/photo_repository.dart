import 'package:chantier_plus/core/service_result.dart';
import 'package:image_picker/image_picker.dart';

abstract class PhotoRepository {
  /// Uploads a list of photos to Firebase Storage and associates them with a specific anomaly.
  ///
  /// The [anomalyId] is used to organize the photos in Firebase Storage, creating a folder for each anomaly.
  /// Each photo will be uploaded under a unique name to avoid conflicts. The method returns a list of
  /// URLs corresponding to the uploaded photos.
  ///
  /// **Parameters:**
  /// - [anomalyId] (String): The unique identifier for the anomaly to associate the photos with.
  /// - [photos] (List<XFile>): A list of [XFile] objects representing the photos to be uploaded.
  ///   [XFile] is a class from the `image_picker` package and contains file metadata, such as the path.
  ///
  /// **Returns:**
  /// - [Future<List<String>>]: A [Future] that resolves to a list of strings, each representing
  ///   the URL of a photo stored in Firebase Storage.
  Future<ServiceResult<List<String>>> uploadAnomalyPhotos(
      String anomalyId, List<XFile> photos);

  Future<ServiceResult<List<String>>> uploadConstructionSItePhotos(
      String constructionSiteId, List<XFile> photos);

  Future<ServiceResult<String>> deleteAllConstructionSitePhotos(String siteId);
}

import 'dart:io';

import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/photo_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PhotoFirebaseStorage implements PhotoRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<ServiceResult<List<String>>> uploadAnomalyPhotos(
      String anomalyId, List<XFile> photos) async {
    List<String> photoUrls = [];
    String photoUrl;

    for (var photo in photos) {
      // Crée un chemin structuré
      final photoRef =
          _firebaseStorage.ref().child('anomalies/$anomalyId/${photo.name}');

      try {
        await photoRef.putFile(File(photo.path));
        photoUrl = await photoRef.getDownloadURL();
      } catch (e) {
        return ServiceResult(error: "Unable to upload photo.");
      }

      photoUrls.add(photoUrl);
    }
    return ServiceResult(content: photoUrls);
  }

  @override
  Future<ServiceResult<List<String>>> uploadConstructionSItePhotos(
      String constructionSiteId, List<XFile> photos) async {
    List<String> photoUrls = [];
    String photoUrl;

    for (var photo in photos) {
      // Crée un chemin structuré
      final photoRef = _firebaseStorage
          .ref()
          .child('constructionSites/$constructionSiteId/${photo.name}');

      try {
        await photoRef.putFile(File(photo.path));
        photoUrl = await photoRef.getDownloadURL();
      } catch (e) {
        return ServiceResult(error: "Unable to upload photo.");
      }

      photoUrls.add(photoUrl);
    }
    return ServiceResult(content: photoUrls);
  }

  @override
  Future<ServiceResult<String>> deleteAllConstructionSitePhotos(
      String siteId) async {
    try {
      // Référence du dossier des photos du chantier
      final directoryRef =
          _firebaseStorage.ref().child('constructionSites/$siteId');

      // Liste tous les objets dans le dossier
      final ListResult result = await directoryRef.listAll();

      // Parcourt chaque objet (fichier) et le supprime
      for (var item in result.items) {
        await item.delete();
      }

      return ServiceResult(content: "All photos deleted successfully.");
    } catch (e) {
      return ServiceResult(error: "Failed to delete photos: ${e.toString()}");
    }
  }
}

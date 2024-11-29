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
}

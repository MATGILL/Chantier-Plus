import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/anomaly_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnomalyFirestore implements AnomalyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Nom de la collection Firestore pour les sites de construction.
  final String _collectionName = 'anomalies';

  @override
  Future<ServiceResult<String>> createAnomaly(Anomaly anomaly) async {
    if (_auth.currentUser == null) {
      return ServiceResult(error: "User not connected");
    }
    final anomaliesRef = _firestore.collection(_collectionName);
    final docRef = anomaliesRef.doc(); // Crée un ID unique

    final anomalyData =
        anomaly.copyWith(authorId: _auth.currentUser!.uid).toJson();

    try {
      await docRef.set(anomalyData);
    } catch (e) {
      ServiceResult(error: "Unable to add the anomaly");
    }

    return ServiceResult(content: docRef.id);
  }

  @override
  Future<ServiceResult<String>> addPhotosToAnomaly(
      String anomalyId, List<String> photos) async {
    if (_auth.currentUser == null) {
      return ServiceResult(error: "User not connected");
    }

    try {
      // Récupère la référence du document d'anomalie
      final anomalyRef = _firestore.collection(_collectionName).doc(anomalyId);

      // Récupère l'anomalie existante
      final anomalySnapshot = await anomalyRef.get();

      if (!anomalySnapshot.exists) {
        return ServiceResult(error: "Anomaly not found");
      }

      // Récupère les photos existantes de l'anomalie
      final anomalyData = anomalySnapshot.data()!;
      List<String> existingPhotos =
          List<String>.from(anomalyData['photos'] ?? []);

      // Ajoute les nouvelles photos à la liste existante
      existingPhotos.addAll(photos);

      // Met à jour le document avec les photos ajoutées
      await anomalyRef.update({
        'photos': existingPhotos,
      });

      return ServiceResult(content: anomalyId); // Retourne l'ID de l'anomalie
    } catch (e) {
      return ServiceResult(
          error: "Unable to add photos to anomaly: ${e.toString()}");
    }
  }

  @override
  Future<ServiceResult<List<Anomaly>>> getAnomalyForConstructionSite(
      String siteId) async {
    try {
      // Récupère les anomalies où le 'constructionSiteId' correspond au siteId
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('constructionSiteid', isEqualTo: siteId)
          .get();

      // Si aucune anomalie n'est trouvée, retourne une liste vide
      if (querySnapshot.docs.isEmpty) {
        return ServiceResult(content: []);
      }

      // Mappe les documents récupérés en objets Anomaly
      List<Anomaly> anomalies = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Anomaly.fromJson(data);
      }).toList();

      return ServiceResult(content: anomalies);
    } catch (e) {
      return ServiceResult(error: "Unable to fetch anomalies: ${e.toString()}");
    }
  }
}

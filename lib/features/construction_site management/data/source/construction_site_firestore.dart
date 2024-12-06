import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/data/dto/construction_site_light.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/role.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/construction_site_repository.dart';
import 'package:chantier_plus/features/construction_site%20management/mapper/construction_site_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConstructionSiteFirestore implements ConstructionSiteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Nom de la collection Firestore pour les sites de construction.
  final String _collectionName = 'construction_sites';

  @override
  Future<ServiceResult<String>> create(
      ConstructionSite constructionSite, String chefId) async {
    if (_firebaseAuth.currentUser == null) {
      return ServiceResult(error: "User not connected");
    }
    final constructionSiteRef = _firestore.collection(_collectionName);
    final docRef = constructionSiteRef.doc(); // Crée un ID unique

    final anomalyData = ConstructionSiteMapper.toFirestore(
        constructionSite, chefId, _firebaseAuth.currentUser!.uid);

    try {
      await docRef.set(anomalyData);
    } catch (e) {
      ServiceResult(error: "Unable to add the anomaly");
    }

    return ServiceResult(content: docRef.id);
  }

  @override
  Future<ServiceResult<String>> delete(String id) async {
    try {
      // Vérifie si l'utilisateur est connecté
      final owner = _firebaseAuth.currentUser;
      if (owner == null) {
        return ServiceResult(error: "Utilisateur non connecté");
      }

      // Récupère la référence du document de chantier
      final docRef = _firestore.collection(_collectionName).doc(id);
      final docSnapshot = await docRef.get();

      // Vérifie si le chantier existe
      if (!docSnapshot.exists) {
        return ServiceResult(error: "Aucun chantier trouvé avec l'ID : $id");
      }

      // Supprime les anomalies associées à ce chantier
      final anomaliesSnapshot = await _firestore
          .collection(
              'anomalies') // Remplacez 'anomalies' par le nom de votre collection d'anomalies
          .where('constructionSiteId', isEqualTo: id)
          .get();

      for (var anomalyDoc in anomaliesSnapshot.docs) {
        await anomalyDoc.reference
            .delete(); // Supprime chaque document d'anomalie
      }

      // Supprime le document de chantier
      await docRef.delete();

      return ServiceResult(
          content: "Chantier et anomalies supprimés avec succès");
    } catch (e) {
      return ServiceResult(
          error:
              "Erreur lors de la suppression du chantier et des anomalies : $e");
    }
  }

  @override
  Future<ServiceResult<List<ConstructionSite>>> getAll(Role role) async {
    final owner = _firebaseAuth.currentUser;
    if (owner != null) {
      try {
        final snapshot = role == Role.chef
            ? await _firestore
                .collection(_collectionName)
                .where("chefId", isEqualTo: owner.uid)
                .get()
            : await _firestore
                .collection(_collectionName)
                .where("respId", isEqualTo: owner.uid)
                .get();

        if (snapshot.docs.isEmpty) {
          return ServiceResult(content: []);
        }

        final constructionSites = snapshot.docs.map((doc) {
          final constructionSiteLightDto =
              ConstructionSiteLightDto.fromJson(doc.data())
                  .copyWith(id: doc.id);
          return ConstructionSiteMapper.fromDto(constructionSiteLightDto);
        }).toList();

        return ServiceResult<List<ConstructionSite>>(
            content: constructionSites);
      } catch (e) {
        return ServiceResult<List<ConstructionSite>>(
            error: "Erreur lors de la récupération des chantiers : $e");
      }
    } else {
      return ServiceResult(error: "Not connected");
    }
  }

  @override
  Future<ServiceResult<ConstructionSite>> getById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (!doc.exists) {
        return ServiceResult(error: "Aucun site trouvé avec l'ID : $id");
      }
      final constructionSiteLightDto =
          ConstructionSiteLightDto.fromJson(doc.data()!).copyWith(id: doc.id);

      return ServiceResult<ConstructionSite>(
          content: ConstructionSiteMapper.fromDto(constructionSiteLightDto));
    } catch (e) {
      return ServiceResult(
          error: "Erreur lors de la récupération du site : $e");
    }
  }

  @override
  Future<ServiceResult<String>> changeStatus(
      String id, Status newStatus) async {
    try {
      // Vérifie si l'utilisateur est connecté
      final owner = _firebaseAuth.currentUser;
      if (owner == null) {
        return ServiceResult(error: "Utilisateur non connecté");
      }

      // Récupère le document correspondant dans Firestore
      final docRef = _firestore.collection(_collectionName).doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        return ServiceResult(error: "Aucun chantier trouvé avec l'ID : $id");
      }

      // Met à jour le statut
      await docRef.update({"status": newStatus.firestoreFormat});

      return ServiceResult(content: "change successfull");
    } catch (e) {
      return ServiceResult(error: "Erreur lors du changement de statut : $e");
    }
  }

  @override
  Future<ServiceResult<String>> addAnomalyToConstructionSite(
      String siteId, String anomalyId) async {
    final constructionSiteRef =
        _firestore.collection(_collectionName).doc(siteId);

    // Vérification de l'existence du chantier
    final constructionSiteSnapshot = await constructionSiteRef.get();

    if (!constructionSiteSnapshot.exists) {
      // Si le site n'existe pas, retour d'une erreur
      return ServiceResult(
          error: "Le site de construction avec l'ID $siteId n'existe pas.");
    }

    try {
      await constructionSiteRef.update({
        'anomalies': FieldValue.arrayUnion([anomalyId]),
      });
      return ServiceResult(content: "Anomaly addedd successfully");
    } catch (e) {
      return ServiceResult(
          error: "unable to add specified anomaly to constructionSite");
    }
  }

  @override
  Future<ServiceResult<String>> addPhotosToConstructionSite(
      String constructionSiteId, List<String> photos) async {
    if (_firebaseAuth.currentUser == null) {
      return ServiceResult(error: "User not connected");
    }

    try {
      // Récupère la référence du document d'anomalie
      final anomalyRef =
          _firestore.collection(_collectionName).doc(constructionSiteId);

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

      return ServiceResult(
          content: constructionSiteId); // Retourne l'ID de l'anomalie
    } catch (e) {
      return ServiceResult(
          error: "Unable to add photos to anomaly: ${e.toString()}");
    }
  }
}

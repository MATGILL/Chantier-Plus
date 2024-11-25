import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/data/dto/construction_site_light.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
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
  Future<void> create(ConstructionSite constructionSite) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ServiceResult<List<ConstructionSite>>> getAll() async {
    final owner = _firebaseAuth.currentUser;
    if (owner != null) {
      try {
        final snapshot = await _firestore
            .collection(_collectionName)
            .where("ownerId", isEqualTo: owner.uid)
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
          ConstructionSiteLightDto.fromJson(doc.data()!);
      return ServiceResult<ConstructionSite>(
          content: ConstructionSiteMapper.fromDto(constructionSiteLightDto));
    } catch (e) {
      return ServiceResult(
          error: "Erreur lors de la récupération du site : $e");
    }
  }

  @override
  Future<void> update(ConstructionSite constructionSite) {
    // TODO: implement update
    throw UnimplementedError();
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
}

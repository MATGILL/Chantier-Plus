import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/supply.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/unavailability.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';
import 'package:chantier_plus/features/resource_mangement/domain/repository/ressource_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResourceFirestore implements RessourceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collectionNameVehicle = 'vehicle';
  final String _collectionNameSupply = 'supply';

  @override
  Future<ServiceResult<List<Vehicle>>> getAvailableVehicleForPeriod(
      HalfDay halfDayBeginning,
      DateTime startingDate,
      int durationInHalfDays) async {
    //récupère tout les vehcile
    final vehiclesRef = _firestore.collection(_collectionNameVehicle);
    final snapshot = await vehiclesRef.get();

    final availableVehicles = <Vehicle>[];

    for (var doc in snapshot.docs) {
      final vehicleData = doc.data();
      final unavailabilities = (vehicleData['unavailabilities'] as List)
          .map((e) => Unavailability.fromJson(e))
          .toList();

      // Vérification des disponibilités
      if (isResourceAvailable(unavailabilities, halfDayBeginning, startingDate,
          durationInHalfDays)) {
        availableVehicles
            .add(Vehicle.fromJson(vehicleData).copyWith(id: doc.id));
      }
    }

    return ServiceResult(content: availableVehicles);
  }

  @override
  Future<ServiceResult<String>> createVehicle(Vehicle vehicle) async {
    if (_auth.currentUser == null) {
      return ServiceResult(error: "User not connected");
    }
    final vehicleRef = _firestore.collection(_collectionNameVehicle);
    final docRef = vehicleRef.doc();

    final vehicleDate = vehicle.toJson();

    try {
      await docRef.set(vehicleDate);
    } catch (e) {
      ServiceResult(error: "Unable to add the vehcile");
    }

    return ServiceResult(content: docRef.id);
  }

  @override
  Future<ServiceResult<List<Supply>>> getAvailableSupplyrPeriod(
      HalfDay halfDayBeginning,
      DateTime startingDate,
      int durationInHalfDays) async {
    //récupère tout les vehcile
    final supplyRef = _firestore.collection(_collectionNameSupply);
    final snapshot = await supplyRef.get();

    final availableSupply = <Supply>[];

    for (var doc in snapshot.docs) {
      final supplyData = doc.data();
      final unavailabilities = (supplyData['unavailabilities'] as List)
          .map((e) => Unavailability.fromJson(e))
          .toList();

      // Vérification des disponibilités
      if (isResourceAvailable(unavailabilities, halfDayBeginning, startingDate,
          durationInHalfDays)) {
        availableSupply.add(Supply.fromJson(supplyData).copyWith(id: doc.id));
      }
    }

    return ServiceResult(content: availableSupply);
  }

  @override
  Future<ServiceResult<String>> createSupply(Supply supply) async {
    if (_auth.currentUser == null) {
      return ServiceResult(error: "User not connected");
    }
    final supplyRef = _firestore.collection(_collectionNameSupply);
    final docRef = supplyRef.doc();

    final supplyData = supply.toJson();

    try {
      await docRef.set(supplyData);
    } catch (e) {
      ServiceResult(error: "Unable to add the supply");
    }

    return ServiceResult(content: docRef.id);
  }

  @override
  Future<ServiceResult<List<Supply>>> getAllSupply() async {
    final owner = _auth.currentUser;
    if (owner != null) {
      try {
        final snapshot =
            await _firestore.collection(_collectionNameSupply).get();

        if (snapshot.docs.isEmpty) {
          return ServiceResult(content: []);
        }

        final supplies = snapshot.docs.map((doc) {
          return Supply.fromJson(doc.data()).copyWith(id: doc.id);
        }).toList();

        return ServiceResult<List<Supply>>(content: supplies);
      } catch (e) {
        return ServiceResult<List<Supply>>(
            error: "Erreur lors de la récupération des fournitures : $e");
      }
    } else {
      return ServiceResult(error: "Not connected");
    }
  }

  @override
  Future<ServiceResult<List<Vehicle>>> getAllVehicle() async {
    final owner = _auth.currentUser;
    if (owner != null) {
      try {
        final snapshot =
            await _firestore.collection(_collectionNameVehicle).get();

        if (snapshot.docs.isEmpty) {
          return ServiceResult(content: []);
        }

        final vehicles = snapshot.docs.map((doc) {
          return Vehicle.fromJson(doc.data()).copyWith(id: doc.id);
        }).toList();

        return ServiceResult<List<Vehicle>>(content: vehicles);
      } catch (e) {
        return ServiceResult<List<Vehicle>>(
            error: "Erreur lors de la récupération des véhicules : $e");
      }
    } else {
      return ServiceResult(error: "Not connected");
    }
  }

  /// Given a list of a resource's unavailabilities check if the given period
  /// does not cover a period contained in this list.
  /// In other word, this methods return [false] if one unavailability or more are found in the list
  /// that intersect woith the given period.
  ///
  bool isResourceAvailable(List<Unavailability> resourceUnavailability,
      HalfDay halfDayStart, DateTime startingDate, int durationInHalfDay) {
    for (var unavailability in resourceUnavailability) {
      if (unavailability.period
          .isOverlaps(halfDayStart, startingDate, durationInHalfDay)) {
        return false;
      }
    }
    return true;
  }

  @override
  Future<ServiceResult<List<Vehicle>>> getAllVehicleFromlistString(
      List<String> siteIds) async {
    try {
      // Obtenir une collection de Firestore
      final vehiclesCollection = _firestore.collection(_collectionNameVehicle);

      // Récupérer tous les documents avec les IDs spécifiés dans la liste
      final documentSnapshots = await Future.wait(
          siteIds.map((siteId) => vehiclesCollection.doc(siteId).get()));

      // Vérifier si aucun document n'a été trouvé
      final vehicles = <Vehicle>[];

      for (final docSnapshot in documentSnapshots) {
        if (docSnapshot.exists) {
          // Transformer les données du document en entité `Vehicle`
          final vehicleData = docSnapshot.data();
          vehicles.add(Vehicle.fromJson(vehicleData as Map<String, dynamic>));
        }
      }

      if (vehicles.isEmpty) {
        return ServiceResult(
            error: "Aucun véhicule trouvé pour les sites spécifiés.");
      }

      return ServiceResult(content: vehicles);
    } catch (e) {
      return ServiceResult(
          error: 'Erreur lors de la récupération des véhicules : $e');
    }
  }

  @override
  Future<ServiceResult<List<Supply>>> getAllSupplyFromlistString(
      List<String> siteIds) async {
    try {
      // Obtenir une collection de Firestore
      final suppliesCollection = _firestore.collection(_collectionNameSupply);

      // Récupérer tous les documents avec les IDs spécifiés dans la liste
      final documentSnapshots = await Future.wait(
          siteIds.map((siteId) => suppliesCollection.doc(siteId).get()));

      // Vérifier si des documents ont été trouvés
      final supplies = <Supply>[];

      for (final docSnapshot in documentSnapshots) {
        if (docSnapshot.exists) {
          if (docSnapshot.exists) {
            // Transformer les données du document en entité `Supply`
            final suppliesData = docSnapshot.data();
            supplies.add(Supply.fromJson(suppliesData as Map<String, dynamic>));
          }
          // Récupérer les données des fournitures à partir du document
        }
      }

      if (supplies.isEmpty) {
        return ServiceResult(
            error: "Aucune fourniture trouvée pour les sites spécifiés.");
      }

      return ServiceResult(content: supplies);
    } catch (e) {
      return ServiceResult(
          error: 'Erreur lors de la récupération des fournitures : $e');
    }
  }
}

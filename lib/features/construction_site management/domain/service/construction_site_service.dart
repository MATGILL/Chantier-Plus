import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/role.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/construction_site_repository.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/photo_repository.dart';
import 'package:chantier_plus/features/resource_mangement/domain/repository/ressource_repository.dart';
import 'package:image_picker/image_picker.dart';

class ConstructionSiteService {
  final ConstructionSiteRepository _repository;
  final PhotoRepository _photoRepository;
  final RessourceRepository _ressourceRepository;
  ConstructionSiteService(
      {required ConstructionSiteRepository constructionSiteRepository,
      required PhotoRepository photoRepository,
      required RessourceRepository ressourceRepository})
      : _repository = constructionSiteRepository,
        _photoRepository = photoRepository,
        _ressourceRepository = ressourceRepository;

  //Récupère l'ensemble des chantier en fonction du role de l'utilisateur courant
  Future<ServiceResult<List<ConstructionSite>>> getAllConstructionSites(
      Role role) {
    return _repository.getAll(role);
  }

  //Change le status d'u chantier
  Future<ServiceResult<String>> changeConstructionSiteStatus(
      String siteId, Status newStatus) {
    return _repository.changeStatus(siteId, newStatus);
  }

  //Créer un nouveau chantier
  Future<ServiceResult<String>> createConstructionSite(
      ConstructionSite constructionSite,
      List<XFile> photos,
      UserEntity chef) async {
    // Création de l'anomalie
    var createAnomalyResult =
        await _repository.create(constructionSite, chef.userId!);
    if (createAnomalyResult.error.isNotEmpty) {
      return ServiceResult(error: "Unable to create anomaly");
    }

    var anomalyId = createAnomalyResult.content;

    // Upload des photos
    if (photos.isNotEmpty) {
      var photoResult = await _photoRepository.uploadConstructionSItePhotos(
          anomalyId!, photos);
      if (photoResult.error.isNotEmpty) {
        return ServiceResult(error: "Unable to upload photo.");
      }

      // Ajout des photos à l'anomalie
      await _repository.addPhotosToConstructionSite(
          anomalyId, photoResult.content!);
    }

    return Future.value(ServiceResult(content: anomalyId));
  }

  Future<ServiceResult<ConstructionSite>> getConstructionSiteById(
      String id) async {
    //Get the constructionSite
    var result = await _repository.getById(id);
    if (result.error.isNotEmpty) {
      return ServiceResult(error: "Unable to get the desire constructionSitet");
    }

    ConstructionSite constructionSite = result.content!;
    var vehicleResult;
    if (constructionSite.vehicles.isNotEmpty) {
      //Load resources
      vehicleResult = await _ressourceRepository.getAllVehicleFromlistString(
          constructionSite.vehicles.map((v) => v.id).toList());
      if (vehicleResult.error.isNotEmpty) {
        return ServiceResult(error: "Unable to get the desire vehicless");
      }
    }

    var suppliesResult;
    if (constructionSite.supplies.isNotEmpty) {
      suppliesResult = await _ressourceRepository.getAllSupplyFromlistString(
          constructionSite.supplies.map((s) => s.id).toList());
      if (vehicleResult.error.isNotEmpty) {
        return ServiceResult(error: "Unable to get the desire vehicless");
      }
    }

    return ServiceResult(
        content: constructionSite.copyWith(
            vehicles: vehicleResult != null ? vehicleResult.content : [],
            supplies: suppliesResult != null ? suppliesResult.content : []));
  }
}

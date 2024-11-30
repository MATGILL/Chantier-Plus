import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/role.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/repository/construction_site_repository.dart';

class ConstructionSiteService {
  final ConstructionSiteRepository _repository;

  ConstructionSiteService(this._repository);

  Future<ServiceResult<List<ConstructionSite>>> getAllConstructionSites(
      Role role) {
    return _repository.getAll(role);
  }

  Future<ServiceResult<String>> changeConstructionSiteStatus(
      String siteId, Status newStatus) {
    return _repository.changeStatus(siteId, newStatus);
  }

  // Méthodes pour create, update, delete si nécessaire...
}

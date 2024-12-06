import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/role.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/service/construction_site_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'construction_site_resp_event.dart';
part 'construction_site_resp_state.dart';

class ConstructionSiteRespBloc
    extends Bloc<ConstructionSiteRespEvent, ConstructionSiteRespState> {
  final ConstructionSiteService _service =
      serviceLocator<ConstructionSiteService>();

  ConstructionSiteRespBloc()
      : super(const ConstructionSiteRespState(
            status: ConstructionStateRespStatus.initial)) {
    on<FetchConstructionSitesResp>(_onFetchConstructionSites);
    on<DeleteConstructionSiteResp>(
        _onDeleteConstructionSite); // Ajout de l'événement de suppression
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _onFetchConstructionSites(
    FetchConstructionSitesResp event,
    Emitter<ConstructionSiteRespState> emit,
  ) async {
    emit(const ConstructionSiteRespState(
        status: ConstructionStateRespStatus.loading));

    // Appel au service pour récupérer les données
    ServiceResult<List<ConstructionSite>> result =
        await _service.getAllConstructionSites(Role.resp);

    // Gestion du succès ou de l'échec
    if (result.error.isEmpty) {
      if (result.content!.isNotEmpty) {
        emit(ConstructionSiteRespState(
            status: ConstructionStateRespStatus.success,
            constructionSites: result.content!,
            totalAnomalies: result.content!
                .map((site) => site.anomalyNumber)
                .reduce((value, element) => value + element)));
      } else {
        emit(const ConstructionSiteRespState(
            status: ConstructionStateRespStatus.success, totalAnomalies: 0));
      }
    } else {
      emit(const ConstructionSiteRespState(
        status: ConstructionStateRespStatus.error,
        constructionSites: [],
      ));
    }
  }

  // Gestionnaire d'événement pour DeleteConstructionSite
  Future<void> _onDeleteConstructionSite(
    DeleteConstructionSiteResp event,
    Emitter<ConstructionSiteRespState> emit,
  ) async {
    emit(const ConstructionSiteRespState(
        status: ConstructionStateRespStatus.loading));

    // Appel au service pour supprimer le chantier
    ServiceResult<String> result =
        await _service.deleteConstructionSite(event.siteId);

    // Gestion du succès ou de l'échec
    if (result.error.isEmpty) {
      // Mise à jour de l'état après la suppression réussie
      add(FetchConstructionSitesResp());
    } else {
      // En cas d'erreur, mise à jour de l'état avec un message d'erreur
      emit(const ConstructionSiteRespState(
        status: ConstructionStateRespStatus.error,
        constructionSites: [],
      ));
    }
  }
}

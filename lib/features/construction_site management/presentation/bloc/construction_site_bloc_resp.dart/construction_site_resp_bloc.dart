import 'package:chantier_plus/core/service_locator.dart';
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
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _onFetchConstructionSites(
    FetchConstructionSitesResp event,
    Emitter<ConstructionSiteRespState> emit,
  ) async {
    emit(const ConstructionSiteRespState(
        status: ConstructionStateRespStatus.loading));

    // Appel au service pour récupérer les données
    final result = await _service.getAllConstructionSites(Role.resp);

    // Gestion du succès ou de l'échec
    if (result.content != null) {
      emit(ConstructionSiteRespState(
        status: ConstructionStateRespStatus.success,
        constructionSites: result.content!,
      ));
    } else {
      emit(const ConstructionSiteRespState(
        status: ConstructionStateRespStatus.error,
        constructionSites: [],
      ));
    }
  }
}

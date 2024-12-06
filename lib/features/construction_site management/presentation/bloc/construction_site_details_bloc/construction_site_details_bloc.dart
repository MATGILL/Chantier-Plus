import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/service/construction_site_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'construction_site_details_envent.dart';
part 'construction_site_details_state.dart';

class ConstructionSiteDetailsBloc
    extends Bloc<ConstructionSiteDetailsEvent, ConstructionDetailsState> {
  final ConstructionSiteService _service =
      serviceLocator<ConstructionSiteService>();

  ConstructionSiteDetailsBloc()
      : super(const ConstructionDetailsState(
            status: ConstructionDetailsStatus.initial)) {
    on<FetchConstructionSite>(_onFetchConstructionSite);
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _onFetchConstructionSite(
    FetchConstructionSite event,
    Emitter<ConstructionDetailsState> emit,
  ) async {
    emit(const ConstructionDetailsState(
        status: ConstructionDetailsStatus.loading));

    // Appel au service pour récupérer les données
    final result = await _service.getConstructionSiteById(event.siteId);

    // Gestion du succès ou de l'échec
    if (result.content != null) {
      emit(ConstructionDetailsState(
        status: ConstructionDetailsStatus.success,
        constructionSite: result.content!,
      ));
    } else {
      emit(const ConstructionDetailsState(
        status: ConstructionDetailsStatus.error,
        constructionSite: ConstructionSite.empty(),
      ));
    }
  }
}

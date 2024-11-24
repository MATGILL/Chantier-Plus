import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/service/construction_site_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'construction_site_event.dart';
part 'construction_site_state.dart';

class ConstructionSiteBloc
    extends Bloc<ConstructionSiteEvent, ConstructionSiteState> {
  final ConstructionSiteService _service =
      serviceLocator<ConstructionSiteService>();

  ConstructionSiteBloc()
      : super(const ConstructionSiteState(
            status: ConstructionStateStatus.initial)) {
    on<FetchConstructionSites>(_onFetchConstructionSites);
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _onFetchConstructionSites(
    FetchConstructionSites event,
    Emitter<ConstructionSiteState> emit,
  ) async {
    emit(const ConstructionSiteState(status: ConstructionStateStatus.loading));

    // Appel au service pour récupérer les données
    final result = await _service.getAllConstructionSites();

    // Gestion du succès ou de l'échec
    if (result.content != null) {
      print(result.content);
      emit(ConstructionSiteState(
        status: ConstructionStateStatus.success,
        constructionSites: result.content!,
      ));
    } else {
      emit(const ConstructionSiteState(
        status: ConstructionStateStatus.error,
        constructionSites: [],
      ));
    }
  }
}

import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/service/anomaly_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'construction_site_anomalies_event.dart';
part 'construction_site_anomalies_state.dart';

class ConstructionSiteAnomaliesBloc extends Bloc<ConstructionSiteAnomaliesEvent,
    ConstructionSiteAnomaliesState> {
  final AnomalyService _anomalyService;

  ConstructionSiteAnomaliesBloc()
      : _anomalyService = serviceLocator<AnomalyService>(),
        super(const ConstructionSiteAnomaliesState(
            status: ConstructionSiteAnomaliesStatus.initial)) {
    on<FetchConstructionSitesAnomalies>(_onFetcANomalies);
  }

  Future<void> _onFetcANomalies(
    FetchConstructionSitesAnomalies event,
    Emitter<ConstructionSiteAnomaliesState> emit,
  ) async {
    emit(const ConstructionSiteAnomaliesState(
        status: ConstructionSiteAnomaliesStatus.loading));

    // Appel au service pour récupérer les données
    final result =
        await _anomalyService.getAnomalyForConstructionSite(event.siteId);

    // Gestion du succès ou de l'échec
    if (result.content != null) {
      emit(ConstructionSiteAnomaliesState(
        status: ConstructionSiteAnomaliesStatus.success,
        anomalies: result.content!,
      ));
    } else {
      emit(const ConstructionSiteAnomaliesState(
        status: ConstructionSiteAnomaliesStatus.error,
        anomalies: [],
      ));
    }
  }
}

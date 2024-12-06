part of 'construction_site_anomalies_bloc.dart';

abstract class ConstructionSiteAnomaliesEvent {}

class FetchConstructionSitesAnomalies extends ConstructionSiteAnomaliesEvent {
  final String siteId;

  FetchConstructionSitesAnomalies(this.siteId);
}

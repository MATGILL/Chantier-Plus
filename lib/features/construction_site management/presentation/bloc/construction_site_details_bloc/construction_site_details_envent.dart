part of 'construction_site_details_bloc.dart';

abstract class ConstructionSiteDetailsEvent {}

class FetchConstructionSite extends ConstructionSiteDetailsEvent {
  final String siteId;

  FetchConstructionSite(this.siteId);
}

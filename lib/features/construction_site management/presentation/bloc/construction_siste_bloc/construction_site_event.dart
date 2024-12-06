part of 'construction_site_bloc.dart';

abstract class ConstructionSiteEvent {}

class FetchConstructionSites extends ConstructionSiteEvent {}

class ChangeConstructionSiteStatus extends ConstructionSiteEvent {
  final String siteId;
  final Status newStatus;

  ChangeConstructionSiteStatus(this.siteId, this.newStatus);
}

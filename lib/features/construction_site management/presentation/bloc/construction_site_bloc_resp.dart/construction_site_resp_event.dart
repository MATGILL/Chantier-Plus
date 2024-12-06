part of 'construction_site_resp_bloc.dart';

abstract class ConstructionSiteRespEvent {}

class FetchConstructionSitesResp extends ConstructionSiteRespEvent {}

class DeleteConstructionSiteResp extends ConstructionSiteRespEvent {
  final String siteId;

  DeleteConstructionSiteResp(this.siteId);
}

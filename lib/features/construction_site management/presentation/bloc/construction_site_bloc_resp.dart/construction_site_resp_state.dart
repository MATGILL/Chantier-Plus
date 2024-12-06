part of 'construction_site_resp_bloc.dart';

enum ConstructionStateRespStatus { initial, loading, success, error }

final class ConstructionSiteRespState extends Equatable {
  const ConstructionSiteRespState(
      {this.status = ConstructionStateRespStatus.initial,
      this.constructionSites = const [],
      this.lastDeletedSite,
      this.totalAnomalies});

  final ConstructionStateRespStatus status;
  final List<ConstructionSite> constructionSites;
  final ConstructionSite? lastDeletedSite;
  final int? totalAnomalies;

  ConstructionSiteRespState copyWith(
      {ConstructionStateRespStatus? status,
      List<ConstructionSite>? constructionSites,
      ConstructionSite? lastDeletedSite,
      int? totalAnomalies}) {
    return ConstructionSiteRespState(
        status: status ?? this.status,
        constructionSites: constructionSites ?? this.constructionSites,
        lastDeletedSite: lastDeletedSite ?? this.lastDeletedSite,
        totalAnomalies: totalAnomalies ?? this.totalAnomalies);
  }

  @override
  List<Object?> get props =>
      [status, constructionSites, lastDeletedSite, totalAnomalies];
}

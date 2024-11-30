part of 'construction_site_resp_bloc.dart';

enum ConstructionStateRespStatus { initial, loading, success, error }

final class ConstructionSiteRespState extends Equatable {
  const ConstructionSiteRespState({
    this.status = ConstructionStateRespStatus.initial,
    this.constructionSites = const [],
    this.lastDeletedSite,
  });

  final ConstructionStateRespStatus status;
  final List<ConstructionSite> constructionSites;
  final ConstructionSite? lastDeletedSite;

  ConstructionSiteRespState copyWith({
    ConstructionStateRespStatus? status,
    List<ConstructionSite>? constructionSites,
    ConstructionSite? lastDeletedSite,
  }) {
    return ConstructionSiteRespState(
      status: status ?? this.status,
      constructionSites: constructionSites ?? this.constructionSites,
      lastDeletedSite: lastDeletedSite ?? this.lastDeletedSite,
    );
  }

  @override
  List<Object?> get props => [
        status,
        constructionSites,
        lastDeletedSite,
      ];
}

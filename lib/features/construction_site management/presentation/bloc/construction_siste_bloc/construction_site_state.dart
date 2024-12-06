part of 'construction_site_bloc.dart';

enum ConstructionStateStatus { initial, loading, success, error }

final class ConstructionSiteState extends Equatable {
  const ConstructionSiteState({
    this.status = ConstructionStateStatus.initial,
    this.constructionSites = const [],
    this.lastDeletedSite,
  });

  final ConstructionStateStatus status;
  final List<ConstructionSite> constructionSites;
  final ConstructionSite? lastDeletedSite;

  ConstructionSiteState copyWith({
    ConstructionStateStatus? status,
    List<ConstructionSite>? constructionSites,
    ConstructionSite? lastDeletedSite,
  }) {
    return ConstructionSiteState(
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

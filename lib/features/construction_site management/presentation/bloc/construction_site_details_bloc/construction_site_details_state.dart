part of 'construction_site_details_bloc.dart';

enum ConstructionDetailsStatus { initial, loading, success, error }

final class ConstructionDetailsState extends Equatable {
  const ConstructionDetailsState({
    this.status = ConstructionDetailsStatus.initial,
    this.constructionSite = const ConstructionSite.empty(),
  });

  final ConstructionDetailsStatus status;
  final ConstructionSite constructionSite;

  ConstructionDetailsState copyWith({
    ConstructionDetailsStatus? status,
    ConstructionSite? constructionSite,
  }) {
    return ConstructionDetailsState(
      status: status ?? this.status,
      constructionSite: constructionSite ?? this.constructionSite,
    );
  }

  @override
  List<Object?> get props => [
        status,
        constructionSite,
      ];
}

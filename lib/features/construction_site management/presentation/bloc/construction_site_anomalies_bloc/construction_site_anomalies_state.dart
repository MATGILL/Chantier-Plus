part of 'construction_site_anomalies_bloc.dart';

enum ConstructionSiteAnomaliesStatus { initial, loading, success, error }

final class ConstructionSiteAnomaliesState extends Equatable {
  const ConstructionSiteAnomaliesState({
    this.status = ConstructionSiteAnomaliesStatus.initial,
    this.anomalies = const [],
  });

  final ConstructionSiteAnomaliesStatus status;
  final List<Anomaly> anomalies;

  ConstructionSiteAnomaliesState copyWith({
    ConstructionSiteAnomaliesStatus? status,
    List<Anomaly>? anomalies,
  }) {
    return ConstructionSiteAnomaliesState(
      status: status ?? this.status,
      anomalies: anomalies ?? this.anomalies,
    );
  }

  @override
  List<Object?> get props => [
        status,
        anomalies,
      ];
}

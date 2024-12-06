part of 'supply_list_bloc.dart';

enum SupplyListStateStatus { initial, loading, success, error }

final class SupplyListState extends Equatable {
  final SupplyListStateStatus status;
  final List<Supply> supplies;

  const SupplyListState({
    this.status = SupplyListStateStatus.initial,
    this.supplies = const [],
  });

  SupplyListState copyWith({
    SupplyListStateStatus? status,
    List<Supply>? supplies,
  }) {
    return SupplyListState(
      status: status ?? this.status,
      supplies: supplies ?? this.supplies,
    );
  }

  @override
  List<Object?> get props => [
        status,
        supplies,
      ];
}

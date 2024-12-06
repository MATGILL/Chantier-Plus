part of 'new_supply_bloc.dart';

enum SupplyStateStatus { initial, loading, success, error }

class CreateSupplyState extends Equatable {
  final SupplyStateStatus status;
  final Supply? supply;
  final String? error;
  final String? typeError; // Ajout du champ pour l'erreur de la marque
  final String? nameError; // Ajout du champ pour l'erreur du modèle

  const CreateSupplyState({
    this.status = SupplyStateStatus.initial,
    this.supply,
    this.error,
    this.typeError,
    this.nameError,
  });

  @override
  List<Object?> get props => [
        status,
        supply ?? '',
        error ?? '',
        typeError ?? '',
        nameError ?? '',
      ];

  CreateSupplyState copyWith({
    SupplyStateStatus? status,
    Supply? supply,
    String? error,
    String? typeError,
    String? nameError,
  }) {
    return CreateSupplyState(
      status: status ?? this.status,
      supply: supply ?? this.supply,
      error: error ?? this.error,
      typeError: typeError ?? this.typeError,
      nameError: nameError ?? this.nameError,
    );
  }
}

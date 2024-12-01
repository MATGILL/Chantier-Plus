part of 'new_supply_bloc.dart';

abstract class CreateSupplyEvent extends Equatable {
  const CreateSupplyEvent();
}

class TypeChanged extends CreateSupplyEvent {
  final String type;

  const TypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}

class NameChanged extends CreateSupplyEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class SubmitSupply extends CreateSupplyEvent {
  const SubmitSupply();

  @override
  List<Object?> get props => [];
}

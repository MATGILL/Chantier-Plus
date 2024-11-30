part of 'new_resource_bloc.dart';

abstract class CreateResourceEvent extends Equatable {
  const CreateResourceEvent();

  @override
  List<Object?> get props => [];
}

class SelectResourceTypeEvent extends CreateResourceEvent {
  final ResourceType resourceType;

  const SelectResourceTypeEvent({
    required this.resourceType,
  });

  @override
  List<Object?> get props => [resourceType];
}

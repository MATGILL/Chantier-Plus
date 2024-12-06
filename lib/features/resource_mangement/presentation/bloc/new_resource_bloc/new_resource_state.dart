part of 'new_resource_bloc.dart';

class ResourceState extends Equatable {
  final ResourceType? resourceType;
  final bool resourceTypeSelected;
  final String? error;

  const ResourceState({
    this.resourceType,
    required this.resourceTypeSelected,
    this.error,
  });

  @override
  List<Object?> get props => [
        resourceType ?? '',
        resourceTypeSelected,
        error ?? '',
      ];

  ResourceState copyWith({
    ResourceStateStatus? status,
    Vehicle? vehicule,
    ResourceType? resourceType,
    bool? resourceTypeSelected,
    String? error,
  }) {
    return ResourceState(
      resourceType: resourceType ?? this.resourceType,
      resourceTypeSelected: resourceTypeSelected ?? this.resourceTypeSelected,
      error: error ?? this.error,
    );
  }
}

enum ResourceStateStatus { initial, loading, success, error }

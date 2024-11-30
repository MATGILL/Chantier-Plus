import 'dart:async';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/resource_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_resource_event.dart';
part 'new_resource_state.dart';

class CreateResourceBloc extends Bloc<CreateResourceEvent, ResourceState> {
  CreateResourceBloc()
      : super(const ResourceState(
          resourceTypeSelected: false,
        )) {
    on<SelectResourceTypeEvent>(_onSelectResourceType);
  }

  // Gestionnaire d'événement pour SelectResourceType
  Future<void> _onSelectResourceType(
    SelectResourceTypeEvent event,
    Emitter<ResourceState> emit,
  ) async {
    emit(state.copyWith(
      resourceType: event.resourceType,
      resourceTypeSelected: true,
    ));
  }
}

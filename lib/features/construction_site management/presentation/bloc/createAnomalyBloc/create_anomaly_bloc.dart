import 'dart:async';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'create_anomaly_event.dart';
part 'create_anomaly_state.dart';

class CreateAnomalyBloc extends Bloc<CreateAnomalyEvent, CreateAnomalyState> {
  final ImagePicker _imagePicker = ImagePicker();
  CreateAnomalyBloc()
      : super(CreateAnomalyState(
          anomaly: Anomaly(
            id: '',
            title: '',
            description: '',
            date: DateTime.now(),
            photos: [],
            author: UserEntity(),
          ),
        )) {
    on<TitleChanged>(_onTitleChanged);

    on<DescriptionChanged>(_descriptionChanged);

    on<PhotoRemoved>(_photoRemoved);

    on<PickPhotoFromCamera>(_pickPhotoFromCamera);

    on<PickPhotoFromGallery>(_pickPhotoFromGallery);

    ///Submit the complete form
    on<SubmitAnomaly>(_onSubmit);
  }

  FutureOr<void> _onTitleChanged(event, emit) {
    emit(state.copyWith(
      anomaly: state.anomaly.copyWith(title: event.title),
    ));
  }

  FutureOr<void> _descriptionChanged(event, emit) {
    emit(state.copyWith(
      anomaly: state.anomaly.copyWith(description: event.description),
    ));
  }

  FutureOr<void> _photoRemoved(event, emit) {
    final updatedPhotos = List<XFile>.from(state.selectedPhotos)
      ..removeWhere((remove) => remove.path == event.photo);
    emit(state.copyWith(
      selectedPhotos: updatedPhotos,
    ));
  }

  FutureOr<void> _pickPhotoFromCamera(event, emit) async {
    try {
      final returnedImage =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (returnedImage != null) {
        emit(state.copyWith(
            selectedPhotos: [...state.selectedPhotos, returnedImage]));
      }
    } catch (e) {
      print("error loading photos");
    }
  }

  FutureOr<void> _pickPhotoFromGallery(event, emit) async {
    try {
      final returnedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        emit(state.copyWith(
            selectedPhotos: [...state.selectedPhotos, returnedImage]));
      }
    } catch (e) {
      print("error loading photos");
    }
  }

  FutureOr<void> _onSubmit(event, emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      // Appel Firebase ou autre service pour enregistrer l'anomalie
      //TODO
      await Future.delayed(const Duration(seconds: 2)); // Placeholder
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, isError: true));
    }
  }
}

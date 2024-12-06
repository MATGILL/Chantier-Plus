import 'dart:async';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/anomaly.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/service/anomaly_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'create_anomaly_event.dart';
part 'create_anomaly_state.dart';

class CreateAnomalyBloc extends Bloc<CreateAnomalyEvent, CreateAnomalyState> {
  final ImagePicker _imagePicker = ImagePicker();
  final AnomalyService _anomalyService;

  CreateAnomalyBloc({required String constructionSiteId})
      : _anomalyService = serviceLocator<AnomalyService>(),
        super(CreateAnomalyState(
          anomaly: Anomaly(
              id: '',
              title: '',
              description: '',
              date: DateTime.now(),
              photos: const [],
              authorId: "",
              constructionSiteId: constructionSiteId),
        )) {
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PickPhotoFromCamera>(_pickPhotoFromCamera);
    on<PickPhotoFromGallery>(_pickPhotoFromGallery);
    on<PhotoRemoved>(_photoRemoved);
    on<SubmitAnomaly>(_onSubmit);
  }

  void _onTitleChanged(TitleChanged event, Emitter<CreateAnomalyState> emit) {
    final title = event.title;

    emit(state.copyWith(
      anomaly: state.anomaly.copyWith(title: title),
    ));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<CreateAnomalyState> emit) {
    final description = event.description;

    emit(state.copyWith(
      anomaly: state.anomaly.copyWith(description: description),
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
    emit(state.copyWith(
      errorMessage: null,
    ));
    try {
      final returnedImage =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (returnedImage != null) {
        emit(state.copyWith(
            selectedPhotos: [...state.selectedPhotos, returnedImage]));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: "Erreur lors de la prise de photo.",
      ));
    }
  }

  FutureOr<void> _pickPhotoFromGallery(event, emit) async {
    emit(state.copyWith(
      errorMessage: null,
    ));
    try {
      final returnedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        emit(state.copyWith(
            selectedPhotos: [...state.selectedPhotos, returnedImage]));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: "Erreur lors de la prise de photo.",
      ));
    }
  }

  Future<void> _onSubmit(
      SubmitAnomaly event, Emitter<CreateAnomalyState> emit) async {
    final titleError = _validateTitle(state.anomaly.title);
    final descriptionError = _validateDescription(state.anomaly.description);

    if (titleError != null || descriptionError != null) {
      emit(state.copyWith(
        titleError: titleError,
        descriptionError: descriptionError,
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      // Appel Firebase ou autre service
      var result = await _anomalyService.createAnomaly(
          state.anomaly, state.selectedPhotos);

      if (result.error.isEmpty) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isError: true));
      }
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, isError: true));
    }
  }

  /// function to validate the Title field.
  /// If it is not valid it return the displayed errorMessage
  String? _validateTitle(String title) {
    if (title.isEmpty) {
      return "Le titre est requis.";
    }
    return null;
  }

  /// function to validate the Title field.
  /// If it is not valid it return the displayed errorMessage
  String? _validateDescription(String description) {
    if (description.isEmpty) {
      return "La description est requise.";
    }
    return null;
  }
}

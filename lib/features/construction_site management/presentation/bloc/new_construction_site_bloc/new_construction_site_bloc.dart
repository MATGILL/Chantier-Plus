import 'dart:async';

import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'new_construction_site_event.dart';
part 'new_construction_site_state.dart';

class NewConstructionBloc
    extends Bloc<NewConstructionEvent, NewConstructionState> {
  final ImagePicker _imagePicker = ImagePicker();

  NewConstructionBloc()
      : super(NewConstructionState(
          constructionSite: const ConstructionSite(
            id: '',
            object: '',
            location: '',
            durationInHalfDays: 0,
            halfDayStarting: HalfDay.morning,
            status: Status.notStarted,
            startingDate: null,
            clientContact: '',
            photos: const [],
            anomalies: const [],
          ),
        )) {
    on<PickPhotoFromCamera>(_pickPhotoFromCamera);
    on<PickPhotoFromGallery>(_pickPhotoFromGallery);
    on<PhotoRemoved>(_photoRemoved);
    on<NameChanged>(_onNameChanged);
    on<NumberHalfDayChanged>(_onNumberHalfDayChanged);
    on<ContactChanged>(_onContactChanged);
    on<DateChanged>(_onDateChanged);
    on<HalfDayChanged>(_onHalfDayChanged);
    on<AddressChanged>(_onAddressChanged);

    //Submit
    on<SubmitConstructionSite>(_onSubmit);
  }

  void _onNameChanged(NameChanged event, Emitter<NewConstructionState> emit) {
    final name = event.name;

    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(object: name),
    ));
  }

  void _onDateChanged(DateChanged event, Emitter<NewConstructionState> emit) {
    final date = event.date;

    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(startingDate: date),
    ));
  }

  void _onNumberHalfDayChanged(
      NumberHalfDayChanged event, Emitter<NewConstructionState> emit) {
    final numberHalfDay = event.numberHalfDay;

    emit(state.copyWith(
      constructionSite:
          state.constructionSite.copyWith(durationInHalfDays: numberHalfDay),
    ));
  }

  void _onContactChanged(
      ContactChanged event, Emitter<NewConstructionState> emit) {
    final contact = event.contact;

    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(clientContact: contact),
    ));
  }

  void _onHalfDayChanged(
      HalfDayChanged event, Emitter<NewConstructionState> emit) {
    final halfDay = event.halfDay;

    emit(state.copyWith(
      constructionSite:
          state.constructionSite.copyWith(halfDayStarting: halfDay),
    ));
  }

  void _onAddressChanged(
      AddressChanged event, Emitter<NewConstructionState> emit) {
    final location = event.location;

    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(location: location),
    ));
  }

  FutureOr<void> _pickPhotoFromCamera(event, emit) async {
    emit(state.copyWith(
      errorPhoto: null,
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
        errorPhoto: "Erreur lors de la prise de photo.",
      ));
    }
  }

  FutureOr<void> _pickPhotoFromGallery(event, emit) async {
    emit(state.copyWith(
      errorPhoto: null,
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
        errorPhoto: "Erreur lors de la prise de photo.",
      ));
    }
  }

  FutureOr<void> _photoRemoved(event, emit) {
    final updatedPhotos = List<XFile>.from(state.selectedPhotos)
      ..removeWhere((remove) => remove.path == event.photo);
    emit(state.copyWith(
      selectedPhotos: updatedPhotos,
    ));
  }

  Future<void> _onSubmit(
      SubmitConstructionSite event, Emitter<NewConstructionState> emit) async {
    final nameError = _validateFiled(state.constructionSite.object, "nom");
    final numberHalfDayError =
        _validateFiledInt(state.constructionSite.durationInHalfDays, "durée");
    final contactError =
        _validateFiledContact(state.constructionSite.clientContact, "contact");
    final validDate =
        _validateFiledDate(state.constructionSite.startingDate, "date");

    if (nameError != null ||
        numberHalfDayError != null ||
        contactError != null ||
        validDate != null) {
      emit(state.copyWith(
          nameError: nameError,
          numberHalfDayError: numberHalfDayError,
          contactError: contactError,
          errorDate: validDate));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    try {
      print(state.constructionSite);
      //TODO change implemù
      // // Appel Firebase ou autre service
      // var result = await _anomalyService.createAnomaly(
      //     state.anomaly, state.selectedPhotos);

      // if (result.error.isEmpty) {
      //   emit(state.copyWith(isSubmitting: false, isSuccess: true));
      // } else {
      //   emit(state.copyWith(isSubmitting: false, isError: true));
      // }
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, isError: true));
    }
  }

  /// function to validate the Title field.
  /// If it is not valid it return the displayed errorMessage
  String? _validateFiled(String field, String fieldName) {
    if (field.isEmpty) {
      return "Le champs $fieldName est requis.";
    }
    return null;
  }

  //FUnction to validate an integer only field
  String? _validateFiledInt(int number, String fieldName) {
    if (number <= 0) {
      return "Le champ $fieldName est requis.";
    }
    return null;
  }

  //FUnction to validate an integer only field
  String? _validateFiledContact(String number, String fieldName) {
    if (number.length < 10) {
      return "Le numéros est au mauvais format.";
    } else if (number.isEmpty) {
      return "Le chanps contact est requis?";
    }
    return null;
  }

  //FUnction to validate an DateTime only field
  String? _validateFiledDate(DateTime? date, String fieldName) {
    if (date == null) {
      return "Le champ $fieldName est requis.";
    }
    return null;
  }
}

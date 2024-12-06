import 'dart:async';

import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/domain/services/auth_service.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/service/construction_site_service.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/supply.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/vehicle.dart';
import 'package:chantier_plus/features/resource_mangement/domain/service/resource_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'new_construction_site_event.dart';
part 'new_construction_site_state.dart';

class NewConstructionBloc
    extends Bloc<NewConstructionEvent, NewConstructionState> {
  final ImagePicker _imagePicker = ImagePicker();
  final ResourceService _service = serviceLocator<ResourceService>();
  final AuthService _authService = serviceLocator<AuthService>();
  final ConstructionSiteService _constructionSiteService =
      serviceLocator<ConstructionSiteService>();

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
            geoPoint: GeoPoint(0, 0),
            photos: [],
            anomalies: [],
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
    on<FetchAvailableResource>(_fetchAvailableSupply);
    on<SelectVehicle>(_selectVehicle);
    on<SelectSupply>(_selectSupply);
    on<RemoveSupply>(_removeSupply);
    on<RemoveVehicle>(_removeVehicle);
    on<FetchAllChef>(_fetchAllChefs);
    on<SelectChef>(_chefSelect);

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
      constructionSite: state.constructionSite
          .copyWith(startingDate: date, supplies: [], vehicles: []),
    ));

    // Déclenchement de FetchAvailableResource
    add(FetchAvailableResource(
      state.constructionSite.halfDayStarting,
      state.constructionSite.startingDate,
      state.constructionSite.durationInHalfDays,
    ));
  }

  void _onNumberHalfDayChanged(
      NumberHalfDayChanged event, Emitter<NewConstructionState> emit) {
    final numberHalfDay = event.numberHalfDay;

    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(
          durationInHalfDays: numberHalfDay, supplies: [], vehicles: []),
    ));

    // Déclenchement de FetchAvailableResource
    add(FetchAvailableResource(
      state.constructionSite.halfDayStarting,
      state.constructionSite.startingDate,
      state.constructionSite.durationInHalfDays,
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
      constructionSite: state.constructionSite
          .copyWith(halfDayStarting: halfDay, supplies: [], vehicles: []),
    ));

    // Déclenchement de FetchAvailableResource
    add(FetchAvailableResource(
      halfDay,
      state.constructionSite.startingDate,
      state.constructionSite.durationInHalfDays,
    ));
  }

  void _onAddressChanged(
      AddressChanged event, Emitter<NewConstructionState> emit) {
    final location = event.location;
    emit(state.copyWith(
      constructionSite: state.constructionSite
          .copyWith(location: location, geoPoint: event.geoPoint),
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

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _fetchAvailableSupply(
    FetchAvailableResource event,
    Emitter<NewConstructionState> emit,
  ) async {
    emit(state.copyWith(status: NewConstructionStatus.loading));

    final ServiceResult<List<Supply>> resultSupplies;
    final ServiceResult<List<Vehicle>> resultVehicle;

    // Appel au service pour récupérer les données
    if (state.constructionSite.startingDate == null) {
      resultSupplies = await _service.getAllSupply();
      resultVehicle = await _service.getAllVehicle();
    } else {
      resultSupplies = await _service.getAvailableSupply(
          state.constructionSite.halfDayStarting,
          state.constructionSite.startingDate!,
          event.durationInDays);

      // Appel au service pour récupérer les données
      resultVehicle = await _service.getAvailableVehicle(
          event.halfDayBeginning, event.startingDate!, event.durationInDays);
    }

    // Gestion du succès ou de l'échec
    if (resultSupplies.content != null) {
      emit(state.copyWith(
        status: NewConstructionStatus.success,
        supplies: resultSupplies.content!,
      ));
    }
    // Gestion du succès ou de l'échec
    if (resultVehicle.content != null) {
      emit(state.copyWith(
        status: NewConstructionStatus.success,
        vehicles: resultVehicle.content!,
      ));
    }
    if (resultVehicle.content == null || resultSupplies.content == null) {
      emit(state.copyWith(
          status: NewConstructionStatus.error, supplies: [], vehicles: []));
    }
  }

  FutureOr<void> _selectVehicle(event, emit) {
    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(
          vehicles: [...state.constructionSite.vehicles, event.vehicle]),
    ));
  }

  FutureOr<void> _removeVehicle(event, emit) {
    if (state.constructionSite.vehicles.contains(event.vehicle)) {
      // Créer une nouvelle liste sans le véhicule à retirer
      final updatedVehicles = state.constructionSite.vehicles
          .where((vehicle) => vehicle != event.vehicle)
          .toList();

      // Émettre un nouvel état avec la liste mise à jour
      emit(state.copyWith(
        constructionSite: state.constructionSite.copyWith(
          vehicles: updatedVehicles,
        ),
      ));
    }
  }

  FutureOr<void> _selectSupply(event, emit) {
    emit(state.copyWith(
      constructionSite: state.constructionSite.copyWith(
          supplies: [...state.constructionSite.supplies, event.supply]),
    ));
  }

  FutureOr<void> _removeSupply(event, emit) {
    if (state.constructionSite.supplies.contains(event.supply)) {
      // Créer une nouvelle liste sans la fourniture à retirer
      final updatedSupplies = state.constructionSite.supplies
          .where((supply) => supply != event.supply)
          .toList();

      // Émettre un nouvel état avec la liste mise à jour
      emit(state.copyWith(
        constructionSite: state.constructionSite.copyWith(
          supplies: updatedSupplies,
        ),
      ));
    }
  }

  // Gestionnaire d'événement pour FetchConstructionSites
  Future<void> _fetchAllChefs(
    FetchAllChef event,
    Emitter<NewConstructionState> emit,
  ) async {
    emit(state.copyWith(status: NewConstructionStatus.loading));

    // Appel au service pour récupérer les données
    final chefList = await _authService.getAllChef();
    // Gestion du succès ou de l'échec
    if (chefList.content != null) {
      emit(state.copyWith(
        status: NewConstructionStatus.success,
        chefs: chefList.content!,
      ));
    }
    if (chefList.content == null) {
      emit(state.copyWith(status: NewConstructionStatus.error, chefs: []));
    }
  }

  FutureOr<void> _chefSelect(event, emit) {
    emit(state.copyWith(selectedChef: event.chef));
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
    final validateChef = _validateChef();
    final validAdress = _validAddress();

    if (nameError != null ||
        numberHalfDayError != null ||
        contactError != null ||
        validDate != null ||
        validateChef != null ||
        validAdress != null) {
      emit(state.copyWith(
          nameError: nameError,
          numberHalfDayError: numberHalfDayError,
          contactError: contactError,
          errorDate: validDate,
          errorChef: validateChef,
          addresseError: validAdress));
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    try {
      // Appel Firebase ou autre service
      var result = await _constructionSiteService.createConstructionSite(
          state.constructionSite, state.selectedPhotos, state.selectedChef!);

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

  String? _validateChef() {
    if (state.selectedChef == null) {
      return "Vous devez sélectionner un chef";
    }
    return null;
  }

  String? _validAddress() {
    if (state.constructionSite.location.isEmpty) {
      return "Vous devez sélectionner une localisation";
    }
    return null;
  }
}

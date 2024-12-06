part of 'new_construction_site_bloc.dart';

enum NewConstructionStatus { initial, loading, success, error }

class NewConstructionState extends Equatable {
  // General
  final int currentStep;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isError;
  final ConstructionSite constructionSite;
  final NewConstructionStatus status;
  final List<Supply> supplies;
  final List<Vehicle> vehicles;
  final List<UserEntity> chefs;

  // Étape 1 : Données du chantier
  final String? nameError;
  final String? numberHalfDayError;
  final String? contactError;
  final String? errorDate;
  final String? addresseError;
  final UserEntity? selectedChef;
  final String? errorChef;

  // Étape 2 : Photos
  final String? errorPhoto;
  final List<XFile> selectedPhotos;

  NewConstructionState({
    this.currentStep = 0,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorChef,
    this.selectedChef,
    required this.constructionSite,
    this.nameError,
    this.numberHalfDayError,
    this.contactError,
    this.errorPhoto,
    this.errorDate,
    this.addresseError,
    this.status = NewConstructionStatus.initial,
    this.supplies = const [],
    this.vehicles = const [],
    this.chefs = const [],
    this.selectedPhotos = const [],
  });

  NewConstructionState copyWith(
      {int? currentStep,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isError,
      ConstructionSite? constructionSite,
      List<XFile>? selectedPhotos,
      String? errorPhoto,
      String? nameError,
      String? numberHalfDayError,
      String? errorDate,
      String? addresseError,
      NewConstructionStatus? status,
      List<Supply>? supplies,
      List<Vehicle>? vehicles,
      List<UserEntity>? chefs,
      UserEntity? selectedChef,
      String? errorChef,
      String? contactError}) {
    return NewConstructionState(
        currentStep: currentStep ?? this.currentStep,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isError: isError ?? this.isError,
        errorPhoto: errorPhoto ?? this.errorPhoto,
        constructionSite: constructionSite ?? this.constructionSite,
        selectedPhotos: selectedPhotos ?? this.selectedPhotos,
        nameError: nameError,
        numberHalfDayError: numberHalfDayError,
        errorDate: errorDate,
        addresseError: addresseError,
        contactError: contactError,
        status: status ?? this.status,
        supplies: supplies ?? this.supplies,
        chefs: chefs ?? this.chefs,
        selectedChef: selectedChef ?? this.selectedChef,
        errorChef: errorChef,
        vehicles: vehicles ?? this.vehicles);
  }

  @override
  List<Object?> get props => [
        currentStep,
        isSubmitting,
        isSuccess,
        isError,
        constructionSite,
        selectedPhotos,
        nameError,
        numberHalfDayError,
        contactError,
        errorPhoto,
        errorDate,
        addresseError,
        status,
        supplies,
        vehicles,
        selectedChef,
        errorChef,
        chefs
      ];
}

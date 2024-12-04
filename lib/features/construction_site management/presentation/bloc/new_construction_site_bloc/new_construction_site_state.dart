part of 'new_construction_site_bloc.dart';

class NewConstructionState extends Equatable {
  // General
  final int currentStep;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isError;
  final ConstructionSite constructionSite;
  final PageController pageController = PageController(initialPage: 0);

  // Étape 1 : Données du chantier
  final String? nameError;
  final String? numberHalfDayError;
  final String? contactError;
  final String? errorDate;
  final String? addresseError;

  // Étape 2 : Photos
  final String? errorPhoto;
  final List<XFile> selectedPhotos;

  NewConstructionState({
    this.currentStep = 0,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isError = false,
    required this.constructionSite,
    this.nameError,
    this.numberHalfDayError,
    this.contactError,
    this.errorPhoto,
    this.errorDate,
    this.addresseError,
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
        contactError: contactError);
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
        addresseError
      ];
}

part of 'create_anomaly_bloc.dart';

class CreateAnomalyState extends Equatable {
  final Anomaly anomaly;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isError;
  final String? titleError;
  final String? descriptionError;
  final List<XFile> selectedPhotos;
  final String? errorMessage;

  const CreateAnomalyState({
    required this.anomaly,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isError = false,
    this.titleError,
    this.descriptionError,
    this.errorMessage,
    this.selectedPhotos = const [],
  });

  CreateAnomalyState copyWith(
      {Anomaly? anomaly,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isError,
      String? titleError,
      String? descriptionError,
      List<XFile>? selectedPhotos,
      String? errorMessage}) {
    return CreateAnomalyState(
        anomaly: anomaly ?? this.anomaly,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isError: isError ?? this.isError,
        titleError: titleError,
        descriptionError: descriptionError,
        selectedPhotos: selectedPhotos ?? this.selectedPhotos,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        anomaly,
        isSubmitting,
        isSuccess,
        isError,
        titleError,
        descriptionError,
        selectedPhotos,
        errorMessage
      ];
}

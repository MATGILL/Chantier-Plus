part of 'create_anomaly_bloc.dart';

class CreateAnomalyState extends Equatable {
  final Anomaly anomaly;
  final bool isSubmitting;
  final bool isSuccess;
  final List<XFile> selectedPhotos;
  final bool isError;

  const CreateAnomalyState(
      {required this.anomaly,
      this.isSubmitting = false,
      this.isSuccess = false,
      this.isError = false,
      this.selectedPhotos = const []});

  CreateAnomalyState copyWith(
      {Anomaly? anomaly,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isError,
      List<XFile>? selectedPhotos}) {
    return CreateAnomalyState(
      anomaly: anomaly ?? this.anomaly,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props =>
      [anomaly, isSubmitting, isSuccess, selectedPhotos, isError];
}

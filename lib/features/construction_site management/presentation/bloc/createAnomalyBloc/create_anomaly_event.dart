part of 'create_anomaly_bloc.dart';

abstract class CreateAnomalyEvent extends Equatable {
  const CreateAnomalyEvent();

  @override
  List<Object?> get props => [];
}

class TitleChanged extends CreateAnomalyEvent {
  final String title;

  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class DescriptionChanged extends CreateAnomalyEvent {
  final String description;

  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class PhotoRemoved extends CreateAnomalyEvent {
  final String photo;

  const PhotoRemoved(this.photo);

  @override
  List<Object?> get props => [photo];
}

class PickPhotoFromCamera extends CreateAnomalyEvent {}

class PickPhotoFromGallery extends CreateAnomalyEvent {}

class SubmitAnomaly extends CreateAnomalyEvent {}

part of 'new_construction_site_bloc.dart';

abstract class NewConstructionEvent extends Equatable {
  const NewConstructionEvent();

  @override
  List<Object?> get props => [];
}

//Step One
class NameChanged extends NewConstructionEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class NumberHalfDayChanged extends NewConstructionEvent {
  final int numberHalfDay;

  const NumberHalfDayChanged(this.numberHalfDay);

  @override
  List<Object?> get props => [numberHalfDay];
}

class ContactChanged extends NewConstructionEvent {
  final String contact;

  const ContactChanged(this.contact);

  @override
  List<Object?> get props => [contact];
}

class DateChanged extends NewConstructionEvent {
  final DateTime date;

  const DateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class HalfDayChanged extends NewConstructionEvent {
  final HalfDay halfDay;

  const HalfDayChanged(this.halfDay);

  @override
  List<Object?> get props => [halfDay];
}

class AddressChanged extends NewConstructionEvent {
  final String location;

  const AddressChanged(this.location);

  @override
  List<Object?> get props => [location];
}

//Photo sélection
class PickPhotoFromCamera extends NewConstructionEvent {}

class PickPhotoFromGallery extends NewConstructionEvent {}

class PhotoRemoved extends NewConstructionEvent {
  final String photo;

  const PhotoRemoved(this.photo);

  @override
  List<Object?> get props => [photo];
}

//End

class SubmitConstructionSite extends NewConstructionEvent {}

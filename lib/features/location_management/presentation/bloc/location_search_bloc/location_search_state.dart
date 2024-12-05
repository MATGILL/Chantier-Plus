part of 'location_search_bloc.dart';

abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchLoading extends LocationSearchState {}

class LocationSearchSuccess extends LocationSearchState {
  final List<MapBoxPlace> places;

  LocationSearchSuccess(this.places);
}

class LocationSearchFailure extends LocationSearchState {
  final String error;

  LocationSearchFailure(this.error);
}

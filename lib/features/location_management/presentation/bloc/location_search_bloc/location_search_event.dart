part of 'location_search_bloc.dart';

abstract class LocationSearchEvent {}

class SearchLocationEvent extends LocationSearchEvent {
  final String query;

  SearchLocationEvent(this.query);
}

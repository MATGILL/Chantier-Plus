import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_search/mapbox_search.dart';

part 'location_search_state.dart';
part 'location_search_event.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final PlacesSearch placesSearch;

  LocationSearchBloc(this.placesSearch) : super(LocationSearchInitial());

  Stream<LocationSearchState> mapEventToState(
      LocationSearchEvent event) async* {
    if (event is SearchLocationEvent) {
      yield LocationSearchLoading();
      try {
        final places = await placesSearch.getPlaces(event.query);
        yield LocationSearchSuccess(places ?? []);
      } catch (e) {
        yield LocationSearchFailure(e.toString());
      }
    }
  }
}

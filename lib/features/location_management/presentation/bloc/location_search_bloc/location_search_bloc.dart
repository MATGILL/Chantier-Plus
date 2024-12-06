import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_search/mapbox_search.dart';

part 'location_search_state.dart';
part 'location_search_event.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final PlacesSearch placesSearch;

  LocationSearchBloc(this.placesSearch) : super(LocationSearchInitial()) {
    on<SearchLocationEvent>(_searchLocationEvent);
  }

  // Modification ici: Utiliser Emitter au lieu de Stream.
  Future<void> _searchLocationEvent(
      SearchLocationEvent event, Emitter<LocationSearchState> emit) async {
    emit(LocationSearchLoading());
    try {
      final places = await placesSearch.getPlaces(event.query);
      emit(LocationSearchSuccess(places ?? []));
    } catch (e) {
      emit(LocationSearchFailure(e.toString()));
    }
  }
}

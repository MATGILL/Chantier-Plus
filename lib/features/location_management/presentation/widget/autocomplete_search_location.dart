import 'package:chantier_plus/features/location_management/presentation/bloc/location_search_bloc/location_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_search/mapbox_search.dart';

class AutoCompleteSearchLocation extends StatelessWidget {
  final Function(String location, GeoPoint geoPoint) onTap;

  const AutoCompleteSearchLocation({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final PlacesSearch placesSearch =
        PlacesSearch(apiKey: dotenv.env['GEOLOC_API_KEY']!, limit: 5);

    return BlocProvider(
        create: (_) => LocationSearchBloc(placesSearch),
        child: BlocBuilder<LocationSearchBloc, LocationSearchState>(
            builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Sélection de l\'adresse')),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        context
                            .read<LocationSearchBloc>()
                            .add(SearchLocationEvent(value));
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Chercher une addresse',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<LocationSearchBloc, LocationSearchState>(
                    builder: (context, state) {
                      if (state is LocationSearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is LocationSearchFailure) {
                        return Center(child: Text('Error: ${state.error}'));
                      }
                      if (state is LocationSearchSuccess) {
                        return ListView.builder(
                          itemCount: state.places.length,
                          itemBuilder: (context, index) {
                            final place = state.places[index];
                            return ListTile(
                              title: Text(place.placeName ?? 'Unknown Place'),
                              subtitle: Text(
                                'Coordinates: ${place.geometry?.coordinates.toString() ?? 'N/A'}',
                              ),
                              onTap: () {
                                onTap(
                                    place.placeName ?? "",
                                    GeoPoint(place.geometry!.coordinates![1],
                                        place.geometry!.coordinates![0]));
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      }
                      return const Center(child: Text('No results'));
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

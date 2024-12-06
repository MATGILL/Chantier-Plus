import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bloc/construction_siste_bloc/construction_site_bloc.dart';

class MapPage extends StatelessWidget {
  final String mapboxAccessToken =
      'pk.eyJ1Ijoicmh1cmJhaW4iLCJhIjoiY200YmVhbXEwMDNlazJrcjR5NTV1cHIzZiJ9.YJYIAlDKtqbvQuwJMxDpzQ';
  final String mapboxStyleId = 'streets-v11';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConstructionSiteBloc()..add(FetchConstructionSites()),
      child: BlocBuilder<ConstructionSiteBloc, ConstructionSiteState>(
        builder: (context, state) {
          if (state.status == ConstructionStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ConstructionStateStatus.success) {
            final constructionSites = state.constructionSites;

            // Create markers from constructionSites
            final List<Marker> markers = constructionSites.map((site) {
              // Parse latitude and longitude from the location string
              final coords = site.location.split(',').map((e) => double.parse(e.trim())).toList();
              final LatLng position = LatLng(coords[0], coords[1]);

              return Marker(
                point: position,
                width: 40.0,
                height: 40.0,
                builder: (context) => GestureDetector(
                  onTap: () {
                    // Show details of the construction site
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Construction Site Details"),
                        content: Text(
                          "Object: ${site.object}\n"
                              "Location: ${site.location}\n"
                              "Status: ${site.status.name}\n"
                              "Lat: ${position.latitude}, Lon: ${position.longitude}",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/cone.png', // Path to your image
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              );
            }).toList();

            return Scaffold(
              body: FlutterMap(
                options: MapOptions(
                  center: LatLng(48.8566, 2.3522), // Centered on Paris
                  zoom: 6.0,
                ),
                children: [
                  // Map layer
                  TileLayer(
                    urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': mapboxAccessToken,
                      'styleId': mapboxStyleId,
                    },
                  ),
                  // Marker layer
                  MarkerLayer(
                    markers: markers,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

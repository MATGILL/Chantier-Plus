import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/construction_site_bloc_resp.dart/construction_site_resp_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/pages/construction_site_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bloc/construction_siste_bloc/construction_site_bloc.dart';

class MaPageResp extends StatelessWidget {
  final String mapboxAccessToken = dotenv.env['GEOLOC_API_KEY']!;
  final String mapboxStyleId = 'streets-v11';
  MaPageResp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConstructionSiteRespBloc()..add(FetchConstructionSitesResp()),
      child: BlocBuilder<ConstructionSiteRespBloc, ConstructionSiteRespState>(
        builder: (context, state) {
          if (state.status == ConstructionStateRespStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ConstructionStateRespStatus.success) {
            final constructionSites = state.constructionSites;
            final List<Marker> markers = constructionSites.map((site) {
              final LatLng position =
                  LatLng(site.geoPoint.latitude, site.geoPoint.longitude);
              return Marker(
                point: position,
                width: 40.0,
                height: 40.0,
                builder: (context) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ConstructionSiteDetailsScreen(siteId: site.id)));
                  },
                  child: Image.asset(
                    'assets/images/cone.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              );
            }).toList();

            return Scaffold(
              body: FlutterMap(
                options: MapOptions(
                  center: LatLng(48.8566, 2.3522),
                  zoom: 6.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/mapbox/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': mapboxAccessToken,
                      'styleId': mapboxStyleId,
                    },
                  ),
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

class MaPageChef extends StatelessWidget {
  final String mapboxAccessToken = dotenv.env['GEOLOC_API_KEY']!;
  final String mapboxStyleId = 'streets-v11';
  MaPageChef({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConstructionSiteBloc()..add(FetchConstructionSites()),
      child: BlocBuilder<ConstructionSiteBloc, ConstructionSiteState>(
        builder: (context, state) {
          // Handle the state here
          if (state.status == ConstructionStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ConstructionStateStatus.success) {
            final constructionSites = state.constructionSites;
            // Create markers from constructionSites
            final List<Marker> markers = constructionSites.map((site) {
              final LatLng position =
                  LatLng(site.geoPoint.latitude, site.geoPoint.longitude);
              return Marker(
                point: position,
                width: 40.0,
                height: 40.0,
                builder: (context) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ConstructionSiteDetailsScreen(siteId: site.id)));
                  },
                  child: Image.asset(
                    'assets/images/cone.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              );
            }).toList();

            return Scaffold(
              body: FlutterMap(
                options: MapOptions(
                  center: LatLng(48.8566, 2.3522),
                  zoom: 6.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/mapbox/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': mapboxAccessToken,
                      'styleId': mapboxStyleId,
                    },
                  ),
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

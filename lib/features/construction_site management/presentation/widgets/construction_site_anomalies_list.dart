import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/construction_site_anomalies_bloc/construction_site_anomalies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ConstructionSiteAnomaliesList extends StatelessWidget {
  final String siteId;

  const ConstructionSiteAnomaliesList({super.key, required this.siteId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConstructionSiteAnomaliesBloc()
        ..add(FetchConstructionSitesAnomalies(siteId)),
      child: BlocBuilder<ConstructionSiteAnomaliesBloc,
          ConstructionSiteAnomaliesState>(
        builder: (context, state) {
          if (state.status == ConstructionSiteAnomaliesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ConstructionSiteAnomaliesStatus.error) {
            return const Center(
                child: Text("Erreur de chargement des anomalies"));
          }

          if (state.status == ConstructionSiteAnomaliesStatus.success &&
              state.anomalies.isEmpty) {
            return const Center(child: Text("Aucune anomalie trouvée"));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.anomalies.length,
            itemBuilder: (context, index) {
              final anomaly = state.anomalies[index];

              return ListTile(
                title: Text(anomaly.title),
                subtitle: Text(anomaly.description),
                onTap: () {
                  // Action sur le tap (par exemple, afficher plus de détails)
                },
                trailing: anomaly.photos.isNotEmpty
                    ? CarouselSlider(
                        items: anomaly.photos.map((photoUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  _showImageDialog(context, photoUrl);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(photoUrl,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 3,
                        ),
                      )
                    : const SizedBox(),
              );
            },
          );
        },
      ),
    );
  }

  // Fonction pour afficher l'image en grand dans un Dialog
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pop(); // Fermer le Dialog quand l'utilisateur clique
            },
            child: Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}

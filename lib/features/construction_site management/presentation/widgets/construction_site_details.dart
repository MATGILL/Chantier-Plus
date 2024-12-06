import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';

class ConstructionSiteDetails extends StatelessWidget {
  final ConstructionSite constructionSite;

  const ConstructionSiteDetails({super.key, required this.constructionSite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du chantier"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carrousel d'images
              if (constructionSite.photos.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: constructionSite.photos.map((photoUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                            child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: double
                              .infinity, // Prendre toute la largeur de l'écran
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[200],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ));
                      },
                    );
                  }).toList(),
                ),

              const SizedBox(height: 20),

              // Informations générales
              Text(
                constructionSite.object,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildInfoRow("Objet :", constructionSite.object),
              _buildInfoRow("Durée :",
                  "${constructionSite.durationInHalfDays} demi-journées"),
              _buildInfoRow(
                  "Date de début :",
                  constructionSite.startingDate != null
                      ? "${constructionSite.startingDate!.toLocal()}"
                          .split(' ')[0]
                      : "Non spécifiée"),
              _buildInfoRow("Lieu :", constructionSite.location),
              _buildInfoRow("Contact client :", constructionSite.clientContact),
              _buildInfoRow(
                  "Statut :", constructionSite.status.name.toLowerCase()),

              const SizedBox(height: 20),
              if (constructionSite.vehicles.isNotEmpty)
                const Text(
                  "Véhicule Assignés ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              if (constructionSite.vehicles.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: constructionSite.vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = constructionSite.vehicles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 10),
                      child: Card(
                        color: AppColors.lightBackground,
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 5,
                              height: 80,
                              color: AppColors.primary,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(vehicle.brand),
                                subtitle: Text(vehicle.model),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              if (constructionSite.supplies.isNotEmpty)
                const Text(
                  "Fourniture Assignés ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              if (constructionSite.supplies.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: constructionSite.supplies.length,
                  itemBuilder: (context, index) {
                    final supply = constructionSite.supplies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 10),
                      child: Card(
                        color: AppColors.lightBackground,
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            // Trait bleu sur la gauche
                            Container(
                              width: 5,
                              height: 80,
                              color: AppColors.primary,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(supply.name),
                                subtitle: Text(supply.type),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              // Nombre d'anomalies
              Text(
                "Anomalies détectées",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text("Nombre d'anomalies : ${constructionSite.anomalyNumber}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

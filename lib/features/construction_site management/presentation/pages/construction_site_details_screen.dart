import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/construction_site_details_bloc/construction_site_details_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/construction_site_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConstructionSiteDetailsScreen extends StatelessWidget {
  final String siteId;
  const ConstructionSiteDetailsScreen({super.key, required this.siteId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ConstructionSiteDetailsBloc()..add(FetchConstructionSite(siteId)),
        child:
            BlocBuilder<ConstructionSiteDetailsBloc, ConstructionDetailsState>(
          builder: (context, state) {
            if (state.status == ConstructionDetailsStatus.loading) {
              // Affichage d'un indicateur de chargement
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state.status == ConstructionDetailsStatus.success) {
              // Affichage des détails du chantier
              return ConstructionSiteDetails(
                constructionSite: state.constructionSite,
              );
            } else {
              return const Scaffold(
                body: Center(child: Text('État inconnu')),
              );
            }
          },
        ));
  }
}

import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/construction_iste_bloc/construction_site_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/construction_site_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConstructionSiteListScreenChef extends StatelessWidget {
  const ConstructionSiteListScreenChef({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConstructionSiteBloc()
        ..add(FetchConstructionSites()), // Bloc initialisé ici
      child: Scaffold(
        body: BlocBuilder<ConstructionSiteBloc, ConstructionSiteState>(
          builder: (context, state) {
            if (state.status == ConstructionStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == ConstructionStateStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("unable to retrieve constructionsite "),
                  backgroundColor: Colors.red,
                ),
              );
              return Container();
            } else if (state.status == ConstructionStateStatus.success) {
              final constructionSites = state.constructionSites;
              return RefreshIndicator(
                onRefresh: () async {
                  // Réappel de l'événement FetchConstructionSites
                  context
                      .read<ConstructionSiteBloc>()
                      .add(FetchConstructionSites());
                },
                child: ListView.builder(
                  itemCount: constructionSites.length,
                  itemBuilder: (context, index) {
                    final constructionSite = constructionSites[index];
                    return ConstructionSiteOverviewCard(
                      constructionSite: constructionSite,
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

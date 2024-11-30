import 'package:chantier_plus/features/construction_site%20management/presentation/bloc/construction_site_bloc_resp.dart/construction_site_resp_bloc.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/construction_card_overview_resp.dart';
import 'package:chantier_plus/features/construction_site%20management/presentation/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConstructionSiteHomeScreenResp extends StatelessWidget {
  const ConstructionSiteHomeScreenResp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConstructionSiteRespBloc()..add(FetchConstructionSitesResp()),
      child: Scaffold(
        body: BlocListener<ConstructionSiteRespBloc, ConstructionSiteRespState>(
          listener: (context, state) {
            if (state.status == ConstructionStateRespStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Unable to retrieve construction sites"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child:
              BlocBuilder<ConstructionSiteRespBloc, ConstructionSiteRespState>(
            builder: (context, state) {
              if (state.status == ConstructionStateRespStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == ConstructionStateRespStatus.success) {
                final constructionSites = state.constructionSites;

                // Exemple de données pour la SummaryCard
                final int ongoingSites = constructionSites.length;
                final int totalAnomalies = constructionSites
                    .map((site) => site.anomalyNumber)
                    .reduce((value, element) => value + element);

                return RefreshIndicator(
                  color: Theme.of(context).progressIndicatorTheme.color,
                  onRefresh: () async {
                    context
                        .read<ConstructionSiteRespBloc>()
                        .add(FetchConstructionSitesResp());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SummaryCard(
                              title: "Résumé général",
                              ongoingSites: ongoingSites,
                              anomalies: totalAnomalies,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Liste des chantiers :",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final constructionSite = constructionSites[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, left: 16.0, right: 16.0),
                                child: ConstructionSiteCardOverviewResp(
                                  key: Key(constructionSite.id),
                                  constructionSite: constructionSite,
                                  onIconPressed: () {},
                                ),
                              );
                            },
                            childCount: constructionSites.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}

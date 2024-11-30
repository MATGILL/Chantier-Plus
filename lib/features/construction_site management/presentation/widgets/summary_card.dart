import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final int ongoingSites;
  final int anomalies;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.ongoingSites,
    required this.anomalies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBackground,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  context,
                  label: "Chantiers en cours",
                  count: ongoingSites,
                  icon: Icons.construction,
                  color: AppColors.primary,
                ),
                _buildSummaryItem(
                  context,
                  label: "Anomalies",
                  count: anomalies,
                  icon: Icons.warning_amber_outlined,
                  color: AppColors.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context,
      {required String label,
      required int count,
      required IconData icon,
      required Color color}) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../state/app_scope.dart';

class FinalRankingScreen extends StatelessWidget {
  const FinalRankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final ranking = controller.ranking;

    if (ranking.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Aucun classement disponible. Saisis des scores dans Tour en cours.',
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: ranking.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final entry = ranking[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(entry.player.name),
            subtitle: Text(
              'Victoires: ${entry.wins} | Diff: ${entry.pointsDiff} | PF: ${entry.pointsFor} | PA: ${entry.pointsAgainst}',
            ),
          ),
        );
      },
    );
  }
}

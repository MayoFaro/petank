import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../state/app_scope.dart';

class PlanOverviewScreen extends StatelessWidget {
  const PlanOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final plan = controller.currentPlan;

    if (plan == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Aucun plan disponible. Crée un tournoi pour générer les tours.',
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Tournoi: ${controller.activeTournamentName ?? '-'}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Template: ${plan.teamTemplate.teamsOf2} équipes de 2 / ${plan.teamTemplate.teamsOf3} équipes de 3',
        ),
        const SizedBox(height: 12),
        ...plan.rounds.map((round) => _RoundCard(round: round)),
      ],
    );
  }
}

class _RoundCard extends StatelessWidget {
  const _RoundCard({required this.round});

  final RoundPlanModel round;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tour ${round.roundIndex + 1}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const Text('Équipes'),
            const SizedBox(height: 4),
            ...round.teams.map(
              (team) => Text(
                'E${team.teamIndex + 1} (${team.size}) : ${team.players.map((p) => p.name).join(', ')}',
              ),
            ),
            const SizedBox(height: 8),
            const Text('Matchs'),
            const SizedBox(height: 4),
            ...round.matches.map((match) {
              final teamA = match.teamA.players.map((p) => p.name).join(' / ');
              final teamB = match.teamB.players.map((p) => p.name).join(' / ');
              return Text('M${match.matchIndex + 1}: $teamA  vs  $teamB');
            }),
          ],
        ),
      ),
    );
  }
}

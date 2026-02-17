import 'package:drift/drift.dart';

import '../../core/models.dart' as core;
import '../local/app_database.dart' as db;

class TournamentRepository {
  TournamentRepository(this._database);

  final db.AppDatabase _database;

  Future<int> createTournamentWithPlan({
    required String name,
    required DateTime date,
    required int roundsCount,
    required int preferredTeamSize,
    required List<core.Player> participants,
    required core.TournamentPlan plan,
  }) async {
    return _database.transaction(() async {
      final tournamentId = await _database
          .into(_database.tournaments)
          .insert(
            db.TournamentsCompanion.insert(
              name: name.trim(),
              date: date,
              nbTours: roundsCount,
              preferredTeamSize: preferredTeamSize,
            ),
          );

      for (final player in participants) {
        await _database
            .into(_database.tournamentPlayers)
            .insert(
              db.TournamentPlayersCompanion.insert(
                tournamentId: tournamentId,
                playerId: player.id,
                joinedRound: const Value(1),
              ),
            );
      }

      for (final round in plan.rounds) {
        final roundId = await _database
            .into(_database.roundPlans)
            .insert(
              db.RoundPlansCompanion.insert(
                tournamentId: tournamentId,
                roundIndex: round.roundIndex,
                status: const Value('PLANNED'),
              ),
            );

        final teamIdByIndex = <int, int>{};

        for (final team in round.teams) {
          final teamId = await _database
              .into(_database.teamPlans)
              .insert(
                db.TeamPlansCompanion.insert(
                  roundId: roundId,
                  teamIndex: team.teamIndex,
                  teamSize: team.size,
                ),
              );

          teamIdByIndex[team.teamIndex] = teamId;

          for (final member in team.players) {
            await _database
                .into(_database.teamMemberPlans)
                .insert(
                  db.TeamMemberPlansCompanion.insert(
                    teamId: teamId,
                    playerId: member.id,
                  ),
                );
          }
        }

        for (final match in round.matches) {
          final teamAId = teamIdByIndex[match.teamA.teamIndex];
          final teamBId = teamIdByIndex[match.teamB.teamIndex];
          if (teamAId == null || teamBId == null) {
            throw StateError('Match incomplet: team index introuvable.');
          }

          await _database
              .into(_database.matchPlans)
              .insert(
                db.MatchPlansCompanion.insert(
                  roundId: roundId,
                  matchIndex: match.matchIndex,
                  teamAId: teamAId,
                  teamBId: teamBId,
                  scoreA: Value(match.scoreA),
                  scoreB: Value(match.scoreB),
                ),
              );
        }
      }

      return tournamentId;
    });
  }
}

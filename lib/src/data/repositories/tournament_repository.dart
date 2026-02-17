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
        await _insertRoundWithTeamsAndMatches(
          tournamentId: tournamentId,
          round: round,
          status: 'PLANNED',
        );
      }

      return tournamentId;
    });
  }

  Future<void> saveMatchScore({
    required int tournamentId,
    required int roundIndex,
    required int matchIndex,
    required int scoreA,
    required int scoreB,
  }) async {
    final round =
        await (_database.select(_database.roundPlans)..where(
              (t) =>
                  t.tournamentId.equals(tournamentId) &
                  t.roundIndex.equals(roundIndex),
            ))
            .getSingleOrNull();

    if (round == null) return;

    await (_database.update(_database.matchPlans)..where(
          (m) => m.roundId.equals(round.id) & m.matchIndex.equals(matchIndex),
        ))
        .write(
          db.MatchPlansCompanion(scoreA: Value(scoreA), scoreB: Value(scoreB)),
        );

    final hasUnscored =
        await (_database.select(_database.matchPlans)..where(
              (m) =>
                  m.roundId.equals(round.id) &
                  (m.scoreA.isNull() | m.scoreB.isNull()),
            ))
            .get()
            .then((rows) => rows.isNotEmpty);

    await (_database.update(
      _database.roundPlans,
    )..where((r) => r.id.equals(round.id))).write(
      db.RoundPlansCompanion(status: Value(hasUnscored ? 'ACTIVE' : 'DONE')),
    );
  }

  Future<void> upsertTournamentPlayer({
    required int tournamentId,
    required int playerId,
    required int joinedRound,
  }) async {
    final existing =
        await (_database.select(_database.tournamentPlayers)..where(
              (t) =>
                  t.tournamentId.equals(tournamentId) &
                  t.playerId.equals(playerId),
            ))
            .getSingleOrNull();

    if (existing == null) {
      await _database
          .into(_database.tournamentPlayers)
          .insert(
            db.TournamentPlayersCompanion.insert(
              tournamentId: tournamentId,
              playerId: playerId,
              joinedRound: Value(joinedRound),
              leftRound: const Value(null),
            ),
          );
    } else {
      await (_database.update(_database.tournamentPlayers)..where(
            (t) =>
                t.tournamentId.equals(tournamentId) &
                t.playerId.equals(playerId),
          ))
          .write(
            db.TournamentPlayersCompanion(
              joinedRound: Value(joinedRound),
              leftRound: const Value(null),
            ),
          );
    }
  }

  Future<void> markTournamentPlayerLeft({
    required int tournamentId,
    required int playerId,
    required int leftRound,
  }) async {
    await (_database.update(_database.tournamentPlayers)..where(
          (t) =>
              t.tournamentId.equals(tournamentId) & t.playerId.equals(playerId),
        ))
        .write(db.TournamentPlayersCompanion(leftRound: Value(leftRound)));
  }

  Future<void> replaceFutureRounds({
    required int tournamentId,
    required int startRoundIndex,
    required List<core.RoundPlanModel> rounds,
  }) async {
    await _database.transaction(() async {
      final toDeleteRounds =
          await (_database.select(_database.roundPlans)..where(
                (r) =>
                    r.tournamentId.equals(tournamentId) &
                    r.roundIndex.isBiggerOrEqualValue(startRoundIndex),
              ))
              .get();

      final roundIds = toDeleteRounds.map((r) => r.id).toList();
      if (roundIds.isNotEmpty) {
        final teams = await (_database.select(
          _database.teamPlans,
        )..where((t) => t.roundId.isIn(roundIds))).get();
        final teamIds = teams.map((t) => t.id).toList();

        if (teamIds.isNotEmpty) {
          await (_database.delete(
            _database.teamMemberPlans,
          )..where((tm) => tm.teamId.isIn(teamIds))).go();
        }

        await (_database.delete(
          _database.matchPlans,
        )..where((m) => m.roundId.isIn(roundIds))).go();

        if (teamIds.isNotEmpty) {
          await (_database.delete(
            _database.teamPlans,
          )..where((t) => t.id.isIn(teamIds))).go();
        }

        await (_database.delete(
          _database.roundPlans,
        )..where((r) => r.id.isIn(roundIds))).go();
      }

      for (final round in rounds) {
        await _insertRoundWithTeamsAndMatches(
          tournamentId: tournamentId,
          round: round,
          status: 'PLANNED',
        );
      }
    });
  }

  Future<void> _insertRoundWithTeamsAndMatches({
    required int tournamentId,
    required core.RoundPlanModel round,
    required String status,
  }) async {
    final roundId = await _database
        .into(_database.roundPlans)
        .insert(
          db.RoundPlansCompanion.insert(
            tournamentId: tournamentId,
            roundIndex: round.roundIndex,
            status: Value(status),
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
}

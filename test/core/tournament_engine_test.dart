import 'package:flutter_test/flutter_test.dart';
import 'package:petank/src/core/models.dart';
import 'package:petank/src/core/round_live_ops.dart';
import 'package:petank/src/core/tournament_engine.dart';

void main() {
  group('TournamentEngine', () {
    final engine = TournamentEngine();

    List<Player> buildPlayers(int count) {
      final roles = [
        PlayerRole.beginner,
        PlayerRole.pointer,
        PlayerRole.shooter,
      ];
      return List<Player>.generate(
        count,
        (i) =>
            Player(id: i + 1, name: 'P${i + 1}', role: roles[i % roles.length]),
      );
    }

    test('generates full plan and respects hard constraints', () {
      final players = buildPlayers(12);
      final plan = engine.generateTournamentPlan(
        players: players,
        roundsCount: 3,
        preference: TeamSizePreference.prefer2,
        seed: 42,
      );

      expect(plan.rounds.length, 3);

      for (final round in plan.rounds) {
        final idsSeen = <int>{};
        for (final team in round.teams) {
          expect(team.size == 2 || team.size == 3, isTrue);

          final beginnerCount = team.players
              .where((p) => p.role == PlayerRole.beginner)
              .length;
          if (team.size == 2) {
            expect(
              beginnerCount <= 1,
              isTrue,
              reason: '2v: no beginner-beginner',
            );
          } else {
            expect(beginnerCount <= 1, isTrue, reason: '3v: max one beginner');
          }

          for (final p in team.players) {
            expect(idsSeen.contains(p.id), isFalse);
            idsSeen.add(p.id);
          }
        }
        expect(idsSeen.length, players.length);
      }
    });

    test('no identical team between consecutive rounds', () {
      final players = buildPlayers(12);
      final plan = engine.generateTournamentPlan(
        players: players,
        roundsCount: 4,
        preference: TeamSizePreference.prefer2,
        seed: 7,
      );

      for (var i = 1; i < plan.rounds.length; i++) {
        final prev = plan.rounds[i - 1].teams.map((t) => t.hash).toSet();
        final current = plan.rounds[i].teams.map((t) => t.hash).toSet();
        final inter = prev.intersection(current);
        expect(inter, isEmpty);
      }
    });

    test('ranking uses wins then points diff', () {
      final players = buildPlayers(8);
      final plan = engine.generateTournamentPlan(
        players: players,
        roundsCount: 1,
        preference: TeamSizePreference.prefer2,
        seed: 1,
      );

      final match = plan.rounds.first.matches.first;
      match.scoreA = 13;
      match.scoreB = 7;

      final ranking = engine.computeRanking(players: players, plan: plan);
      expect(ranking.first.wins >= ranking.last.wins, isTrue);
    });

    test('live ops add/remove/replace only when valid', () {
      final players = buildPlayers(12);
      final plan = engine.generateTournamentPlan(
        players: players,
        roundsCount: 1,
        preference: TeamSizePreference.prefer2,
        seed: 3,
      );
      final round = plan.rounds.first;

      final teamOf2 = round.teams.firstWhere((t) => t.size == 2);
      final outsider = Player(
        id: 999,
        name: 'Late Joiner',
        role: PlayerRole.pointer,
      );

      final addOk = RoundLiveOps.addPlayerToTeam(
        round: round,
        teamIndex: teamOf2.teamIndex,
        player: outsider,
      );
      expect(addOk, isTrue);
      expect(teamOf2.size, 3);

      final removeOk = RoundLiveOps.removePlayerFromTeam(
        round: round,
        teamIndex: teamOf2.teamIndex,
        playerId: outsider.id,
      );
      expect(removeOk, isTrue);
      expect(teamOf2.size, 2);

      final replaceOk = RoundLiveOps.replacePlayer(
        round: round,
        teamIndex: teamOf2.teamIndex,
        outPlayerId: teamOf2.players.first.id,
        inPlayer: outsider,
      );
      expect(replaceOk, isTrue);
      expect(teamOf2.players.any((p) => p.id == outsider.id), isTrue);
    });
  });
}

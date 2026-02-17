import 'dart:math';

import 'models.dart';
import 'team_size_solver.dart';

class TournamentEngine {
  TournamentEngine({TeamSizeSolver? teamSizeSolver})
    : _teamSizeSolver = teamSizeSolver ?? const TeamSizeSolver();

  final TeamSizeSolver _teamSizeSolver;

  static const double _inf = 1e12;
  static const double _globalRepeatPenalty = 120;
  static const double _prevRoundRepeatPenalty = 400;
  static const double _playedWithWeight = 14;

  TournamentPlan generateTournamentPlan({
    required List<Player> players,
    required int roundsCount,
    required TeamSizePreference preference,
    int? seed,
  }) {
    final activePlayers = players
        .where((p) => p.activePool)
        .toList(growable: false);
    if (activePlayers.length < 4) {
      throw const TournamentGenerationException('Pas assez de joueurs actifs.');
    }
    if (roundsCount < 1) {
      throw const TournamentGenerationException(
        'Le nombre de tours doit être >= 1.',
      );
    }

    _validateRoleFeasibility(activePlayers, allowRelaxedConstraints: false);

    final random = Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final counters = PairingCounters();
    final teamTemplate = _teamSizeSolver.solve(
      playerCount: activePlayers.length,
      preference: preference,
    );

    final globalHashes = <String>{};
    var previousRoundHashes = <String>{};
    final rounds = <RoundPlanModel>[];

    for (var roundIndex = 0; roundIndex < roundsCount; roundIndex++) {
      final teams = _generateRoundTeams(
        roundIndex: roundIndex,
        players: activePlayers,
        templateSizes: teamTemplate.sizes,
        counters: counters,
        globalHashes: globalHashes,
        previousRoundHashes: previousRoundHashes,
        random: random,
        allowRelaxedConstraints: false,
      );

      final matches = _pairTeamsGreedy(
        roundIndex: roundIndex,
        teams: teams,
        counters: counters,
        random: random,
      );

      _updateCountersAndHashesForRound(
        counters: counters,
        globalHashes: globalHashes,
        round: RoundPlanModel(
          roundIndex: roundIndex,
          teams: teams,
          matches: matches,
        ),
      );

      previousRoundHashes = teams.map((t) => t.hash).toSet();
      rounds.add(
        RoundPlanModel(roundIndex: roundIndex, teams: teams, matches: matches),
      );
    }

    return TournamentPlan(
      roundsCount: roundsCount,
      preference: preference,
      teamTemplate: teamTemplate,
      rounds: rounds,
    );
  }

  List<RoundPlanModel> regenerateFutureRounds({
    required List<Player> players,
    required TeamSizePreference preference,
    required int totalRounds,
    required int startRoundIndex,
    required List<RoundPlanModel> lockedRounds,
    required bool allowRelaxedConstraints,
    int? seed,
  }) {
    final activePlayers = players
        .where((p) => p.activePool)
        .toList(growable: false);

    _validateRoleFeasibility(
      activePlayers,
      allowRelaxedConstraints: allowRelaxedConstraints,
    );

    final teamTemplate = _teamSizeSolver.solve(
      playerCount: activePlayers.length,
      preference: preference,
    );

    final random = Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final counters = PairingCounters();
    final globalHashes = <String>{};

    for (final round in lockedRounds) {
      _updateCountersAndHashesForRound(
        counters: counters,
        globalHashes: globalHashes,
        round: round,
      );
    }

    var previousRoundHashes = <String>{};
    final prevRound = lockedRounds
        .where((r) => r.roundIndex == startRoundIndex - 1)
        .toList();
    if (prevRound.isNotEmpty) {
      previousRoundHashes = prevRound.first.teams.map((t) => t.hash).toSet();
    }

    final regenerated = <RoundPlanModel>[];
    for (
      var roundIndex = startRoundIndex;
      roundIndex < totalRounds;
      roundIndex++
    ) {
      final teams = _generateRoundTeams(
        roundIndex: roundIndex,
        players: activePlayers,
        templateSizes: teamTemplate.sizes,
        counters: counters,
        globalHashes: globalHashes,
        previousRoundHashes: previousRoundHashes,
        random: random,
        allowRelaxedConstraints: allowRelaxedConstraints,
      );

      final matches = _pairTeamsGreedy(
        roundIndex: roundIndex,
        teams: teams,
        counters: counters,
        random: random,
      );

      final round = RoundPlanModel(
        roundIndex: roundIndex,
        teams: teams,
        matches: matches,
      );
      _updateCountersAndHashesForRound(
        counters: counters,
        globalHashes: globalHashes,
        round: round,
      );

      previousRoundHashes = teams.map((t) => t.hash).toSet();
      regenerated.add(round);
    }

    return regenerated;
  }

  List<RankingEntry> computeRanking({
    required List<Player> players,
    required TournamentPlan plan,
  }) {
    final wins = <int, int>{};
    final pointsFor = <int, int>{};
    final pointsAgainst = <int, int>{};

    for (final p in players) {
      wins[p.id] = 0;
      pointsFor[p.id] = 0;
      pointsAgainst[p.id] = 0;
    }

    for (final round in plan.rounds) {
      for (final match in round.matches) {
        final scoreA = match.scoreA;
        final scoreB = match.scoreB;
        if (scoreA == null || scoreB == null) {
          continue;
        }

        if (scoreA > scoreB) {
          for (final p in match.teamA.players) {
            wins[p.id] = (wins[p.id] ?? 0) + 1;
          }
        } else if (scoreB > scoreA) {
          for (final p in match.teamB.players) {
            wins[p.id] = (wins[p.id] ?? 0) + 1;
          }
        }

        for (final p in match.teamA.players) {
          pointsFor[p.id] = (pointsFor[p.id] ?? 0) + scoreA;
          pointsAgainst[p.id] = (pointsAgainst[p.id] ?? 0) + scoreB;
        }

        for (final p in match.teamB.players) {
          pointsFor[p.id] = (pointsFor[p.id] ?? 0) + scoreB;
          pointsAgainst[p.id] = (pointsAgainst[p.id] ?? 0) + scoreA;
        }
      }
    }

    final ranking = players
        .map(
          (p) => RankingEntry(
            player: p,
            wins: wins[p.id] ?? 0,
            pointsFor: pointsFor[p.id] ?? 0,
            pointsAgainst: pointsAgainst[p.id] ?? 0,
          ),
        )
        .toList();

    ranking.sort((a, b) {
      final winsCompare = b.wins.compareTo(a.wins);
      if (winsCompare != 0) {
        return winsCompare;
      }
      final diffCompare = b.pointsDiff.compareTo(a.pointsDiff);
      if (diffCompare != 0) {
        return diffCompare;
      }
      return a.player.name.compareTo(b.player.name);
    });

    return ranking;
  }

  List<TeamAssignment> _generateRoundTeams({
    required int roundIndex,
    required List<Player> players,
    required List<int> templateSizes,
    required PairingCounters counters,
    required Set<String> globalHashes,
    required Set<String> previousRoundHashes,
    required Random random,
    required bool allowRelaxedConstraints,
  }) {
    final sortedSizes = templateSizes.toList()..sort((a, b) => b.compareTo(a));

    final strict = _buildRoundGreedy(
      roundIndex: roundIndex,
      players: players,
      sizes: sortedSizes,
      counters: counters,
      globalHashes: globalHashes,
      previousRoundHashes: previousRoundHashes,
      strictPreviousRound: true,
      random: random,
      attempts: 120,
      allowRelaxedConstraints: allowRelaxedConstraints,
    );

    final relaxed =
        strict ??
        _buildRoundGreedy(
          roundIndex: roundIndex,
          players: players,
          sizes: sortedSizes,
          counters: counters,
          globalHashes: globalHashes,
          previousRoundHashes: previousRoundHashes,
          strictPreviousRound: false,
          random: random,
          attempts: 120,
          allowRelaxedConstraints: allowRelaxedConstraints,
        );

    if (relaxed == null) {
      throw TournamentGenerationException(
        'Impossible de générer le tour ${roundIndex + 1} avec les contraintes actuelles.',
      );
    }

    return relaxed;
  }

  List<TeamAssignment>? _buildRoundGreedy({
    required int roundIndex,
    required List<Player> players,
    required List<int> sizes,
    required PairingCounters counters,
    required Set<String> globalHashes,
    required Set<String> previousRoundHashes,
    required bool strictPreviousRound,
    required Random random,
    required int attempts,
    required bool allowRelaxedConstraints,
  }) {
    List<TeamAssignment>? best;
    var bestScore = _inf;

    for (var attempt = 0; attempt < attempts; attempt++) {
      final remaining = List<Player>.from(players)..shuffle(random);
      final teams = <TeamAssignment>[];
      var attemptScore = 0.0;
      var valid = true;

      for (var i = 0; i < sizes.length; i++) {
        final size = sizes[i];
        final combos = _combinations(remaining, size);
        final remainingSizes = sizes.sublist(i + 1);
        final choices = <_CandidateChoice>[];

        for (final combo in combos) {
          final score = _scoreTeam(
            players: combo,
            counters: counters,
            globalHashes: globalHashes,
            previousRoundHashes: previousRoundHashes,
            strictPreviousRound: strictPreviousRound,
            allowRelaxedConstraints: allowRelaxedConstraints,
          );
          if (score >= _inf) {
            continue;
          }

          final pickedIds = combo.map((p) => p.id).toSet();
          final futurePlayers = remaining
              .where((p) => !pickedIds.contains(p.id))
              .toList(growable: false);

          if (!_futureFeasible(
            futurePlayers,
            remainingSizes,
            allowRelaxedConstraints: allowRelaxedConstraints,
          )) {
            continue;
          }

          final jitter = random.nextDouble() * 0.01;
          choices.add(_CandidateChoice(players: combo, score: score + jitter));
        }

        if (choices.isEmpty) {
          valid = false;
          break;
        }

        choices.sort((a, b) => a.score.compareTo(b.score));
        final topBand = min(4, choices.length);
        final picked = choices[random.nextInt(topBand)];

        attemptScore += picked.score;
        final chosenIds = picked.players.map((p) => p.id).toSet();
        remaining.removeWhere((p) => chosenIds.contains(p.id));

        teams.add(
          TeamAssignment(
            roundIndex: roundIndex,
            teamIndex: i,
            players: List<Player>.from(picked.players),
          ),
        );
      }

      if (!valid || remaining.isNotEmpty) {
        continue;
      }

      if (attemptScore < bestScore) {
        bestScore = attemptScore;
        best = teams;
      }
    }

    return best;
  }

  bool _futureFeasible(
    List<Player> players,
    List<int> sizes, {
    required bool allowRelaxedConstraints,
  }) {
    if (sizes.isEmpty) {
      return players.isEmpty;
    }

    if (allowRelaxedConstraints) {
      return true;
    }

    final beginnerCount = _countBeginners(players);
    final maxBeginners = sizes.length; // max 1 beginner per team
    if (beginnerCount > maxBeginners) {
      return false;
    }

    return true;
  }

  int _countBeginners(List<Player> players) {
    return players.where((p) => p.role == PlayerRole.beginner).length;
  }

  double _scoreTeam({
    required List<Player> players,
    required PairingCounters counters,
    required Set<String> globalHashes,
    required Set<String> previousRoundHashes,
    required bool strictPreviousRound,
    required bool allowRelaxedConstraints,
  }) {
    if (players.length < 2 || players.length > 3) {
      return _inf;
    }

    var score = 0.0;
    var beginnerCount = 0;
    var shooterCount = 0;

    for (final p in players) {
      if (p.role == PlayerRole.beginner) beginnerCount++;
      if (p.role == PlayerRole.shooter) shooterCount++;
    }

    if (players.length == 2 && beginnerCount >= 2) {
      if (!allowRelaxedConstraints) return _inf;
      score += 120;
    }
    if (players.length == 3 && beginnerCount >= 2) {
      if (!allowRelaxedConstraints) return _inf;
      score += 120;
    }

    for (var i = 0; i < players.length; i++) {
      for (var j = i + 1; j < players.length; j++) {
        final a = players[i];
        final b = players[j];
        final pairCost = _pairCost(a.role, b.role);
        if (pairCost >= _inf) {
          if (!allowRelaxedConstraints) return _inf;
          score += 60;
        } else {
          score += pairCost;
        }
        score += counters.playedWithCount(a.id, b.id) * _playedWithWeight;
      }
    }

    if (players.length == 3 && shooterCount >= 2) {
      score += 10;
    }

    final hash = _hashForPlayers(players);
    if (previousRoundHashes.contains(hash)) {
      if (strictPreviousRound) {
        return _inf;
      }
      score += _prevRoundRepeatPenalty;
    }

    if (globalHashes.contains(hash)) {
      score += _globalRepeatPenalty;
    }

    return score;
  }

  double _pairCost(PlayerRole a, PlayerRole b) {
    final lo = min(a.value, b.value);
    final hi = max(a.value, b.value);

    if (lo == 1 && hi == 1) return _inf;
    if (lo == 2 && hi == 3) return -8;
    if (lo == 1 && hi == 3) return -6;
    if (lo == 1 && hi == 2) return 6;
    if (lo == 2 && hi == 2) return 5;
    if (lo == 3 && hi == 3) return 7;

    return 0;
  }

  List<MatchAssignment> _pairTeamsGreedy({
    required int roundIndex,
    required List<TeamAssignment> teams,
    required PairingCounters counters,
    required Random random,
  }) {
    final unpaired = List<TeamAssignment>.from(teams);
    final matches = <MatchAssignment>[];
    var matchIndex = 0;

    while (unpaired.isNotEmpty) {
      final teamA = unpaired.removeAt(0);

      var bestIndex = 0;
      var bestCost =
          _crossTeamFacedCost(teamA, unpaired[0], counters) +
          random.nextDouble() * 0.001;
      for (var i = 1; i < unpaired.length; i++) {
        final cost =
            _crossTeamFacedCost(teamA, unpaired[i], counters) +
            random.nextDouble() * 0.001;
        if (cost < bestCost) {
          bestCost = cost;
          bestIndex = i;
        }
      }

      final teamB = unpaired.removeAt(bestIndex);
      for (final a in teamA.players) {
        for (final b in teamB.players) {
          counters.incFaced(a.id, b.id);
        }
      }

      matches.add(
        MatchAssignment(
          roundIndex: roundIndex,
          matchIndex: matchIndex,
          teamA: teamA,
          teamB: teamB,
        ),
      );
      matchIndex++;
    }

    return matches;
  }

  void _updateCountersAndHashesForRound({
    required PairingCounters counters,
    required Set<String> globalHashes,
    required RoundPlanModel round,
  }) {
    for (final team in round.teams) {
      for (var i = 0; i < team.players.length; i++) {
        for (var j = i + 1; j < team.players.length; j++) {
          counters.incPlayedWith(team.players[i].id, team.players[j].id);
        }
      }
      globalHashes.add(team.hash);
    }

    for (final match in round.matches) {
      for (final pa in match.teamA.players) {
        for (final pb in match.teamB.players) {
          counters.incFaced(pa.id, pb.id);
        }
      }
    }
  }

  double _crossTeamFacedCost(
    TeamAssignment a,
    TeamAssignment b,
    PairingCounters counters,
  ) {
    var cost = 0.0;
    for (final pa in a.players) {
      for (final pb in b.players) {
        cost += counters.facedCount(pa.id, pb.id) * 3;
      }
    }
    return cost;
  }

  List<List<Player>> _combinations(List<Player> items, int choose) {
    final result = <List<Player>>[];
    final current = <Player>[];

    void backtrack(int start) {
      if (current.length == choose) {
        result.add(List<Player>.from(current));
        return;
      }
      final needed = choose - current.length;
      final maxStart = items.length - needed;
      for (var i = start; i <= maxStart; i++) {
        current.add(items[i]);
        backtrack(i + 1);
        current.removeLast();
      }
    }

    backtrack(0);
    return result;
  }

  String _hashForPlayers(List<Player> players) {
    final ids = players.map((p) => p.id).toList()..sort();
    return ids.join('-');
  }

  void _validateRoleFeasibility(
    List<Player> players, {
    required bool allowRelaxedConstraints,
  }) {
    if (allowRelaxedConstraints) {
      return;
    }

    final beginnerCount = players
        .where((p) => p.role == PlayerRole.beginner)
        .length;
    final nonBeginnerCount = players.length - beginnerCount;

    if (beginnerCount == players.length) {
      throw const TournamentGenerationException(
        'Tous les joueurs sont Débutants: impossible de respecter les contraintes hard.',
      );
    }

    if (beginnerCount > nonBeginnerCount * 2) {
      throw TournamentGenerationException(
        'Trop de Débutants ($beginnerCount) pour garantir les contraintes hard.',
      );
    }
  }
}

class _CandidateChoice {
  const _CandidateChoice({required this.players, required this.score});

  final List<Player> players;
  final double score;
}

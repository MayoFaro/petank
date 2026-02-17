import 'dart:math';

enum PlayerRole {
  beginner(1),
  pointer(2),
  shooter(3);

  const PlayerRole(this.value);
  final int value;
}

enum TeamSizePreference { prefer2, prefer3 }

class Player {
  const Player({
    required this.id,
    required this.name,
    required this.role,
    this.activePool = true,
  });

  final int id;
  final String name;
  final PlayerRole role;
  final bool activePool;
}

class TeamTemplate {
  const TeamTemplate({required this.teamsOf2, required this.teamsOf3});

  final int teamsOf2;
  final int teamsOf3;

  int get teamCount => teamsOf2 + teamsOf3;

  List<int> get sizes => [
    ...List<int>.filled(teamsOf3, 3),
    ...List<int>.filled(teamsOf2, 2),
  ];
}

class TeamAssignment {
  TeamAssignment({
    required this.roundIndex,
    required this.teamIndex,
    required this.players,
  });

  final int roundIndex;
  final int teamIndex;
  final List<Player> players;

  int get size => players.length;

  String get hash {
    final ids = players.map((p) => p.id).toList()..sort();
    return ids.join('-');
  }
}

class MatchAssignment {
  MatchAssignment({
    required this.roundIndex,
    required this.matchIndex,
    required this.teamA,
    required this.teamB,
    this.scoreA,
    this.scoreB,
  });

  final int roundIndex;
  final int matchIndex;
  final TeamAssignment teamA;
  final TeamAssignment teamB;
  int? scoreA;
  int? scoreB;
}

class RoundPlanModel {
  RoundPlanModel({
    required this.roundIndex,
    required this.teams,
    required this.matches,
  });

  final int roundIndex;
  final List<TeamAssignment> teams;
  final List<MatchAssignment> matches;
}

class TournamentPlan {
  TournamentPlan({
    required this.roundsCount,
    required this.preference,
    required this.teamTemplate,
    required this.rounds,
  });

  final int roundsCount;
  final TeamSizePreference preference;
  final TeamTemplate teamTemplate;
  final List<RoundPlanModel> rounds;
}

class RankingEntry {
  const RankingEntry({
    required this.player,
    required this.wins,
    required this.pointsFor,
    required this.pointsAgainst,
  });

  final Player player;
  final int wins;
  final int pointsFor;
  final int pointsAgainst;

  int get pointsDiff => pointsFor - pointsAgainst;
}

class TournamentGenerationException implements Exception {
  const TournamentGenerationException(this.message);

  final String message;

  @override
  String toString() => 'TournamentGenerationException: $message';
}

class PairingCounters {
  PairingCounters();

  final Map<int, Map<int, int>> playedWith = {};
  final Map<int, Map<int, int>> faced = {};

  int playedWithCount(int a, int b) => _getSymmetric(playedWith, a, b);

  int facedCount(int a, int b) => _getSymmetric(faced, a, b);

  void incPlayedWith(int a, int b) => _incSymmetric(playedWith, a, b);

  void incFaced(int a, int b) => _incSymmetric(faced, a, b);

  int _getSymmetric(Map<int, Map<int, int>> map, int a, int b) {
    if (a == b) return 0;
    final lo = min(a, b);
    final hi = max(a, b);
    return map[lo]?[hi] ?? 0;
  }

  void _incSymmetric(Map<int, Map<int, int>> map, int a, int b) {
    if (a == b) return;
    final lo = min(a, b);
    final hi = max(a, b);
    map.putIfAbsent(lo, () => {})[hi] = (map[lo]?[hi] ?? 0) + 1;
  }
}

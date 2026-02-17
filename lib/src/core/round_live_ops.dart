import 'models.dart';

class RoundLiveOps {
  const RoundLiveOps._();

  static bool addPlayerToTeam({
    required RoundPlanModel round,
    required int teamIndex,
    required Player player,
  }) {
    if (_isAlreadyInRound(round, player.id)) {
      return false;
    }

    final team = round.teams.firstWhere((t) => t.teamIndex == teamIndex);
    if (team.players.length != 2) {
      return false;
    }

    team.players.add(player);
    return true;
  }

  static bool removePlayerFromTeam({
    required RoundPlanModel round,
    required int teamIndex,
    required int playerId,
  }) {
    final team = round.teams.firstWhere((t) => t.teamIndex == teamIndex);
    if (team.players.length != 3) {
      return false;
    }

    final before = team.players.length;
    team.players.removeWhere((p) => p.id == playerId);
    return team.players.length < before;
  }

  static bool replacePlayer({
    required RoundPlanModel round,
    required int teamIndex,
    required int outPlayerId,
    required Player inPlayer,
  }) {
    if (_isAlreadyInRound(round, inPlayer.id)) {
      return false;
    }

    final team = round.teams.firstWhere((t) => t.teamIndex == teamIndex);
    final idx = team.players.indexWhere((p) => p.id == outPlayerId);
    if (idx == -1) {
      return false;
    }

    team.players[idx] = inPlayer;
    return true;
  }

  static bool _isAlreadyInRound(RoundPlanModel round, int playerId) {
    for (final team in round.teams) {
      if (team.players.any((p) => p.id == playerId)) {
        return true;
      }
    }
    return false;
  }
}

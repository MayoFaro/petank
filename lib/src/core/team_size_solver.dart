import 'models.dart';

class TeamSizeSolver {
  const TeamSizeSolver();

  TeamTemplate solve({
    required int playerCount,
    required TeamSizePreference preference,
  }) {
    if (playerCount < 4) {
      throw const TournamentGenerationException(
        'Au moins 4 joueurs sont nécessaires.',
      );
    }

    final candidates = <TeamTemplate>[];
    for (var teamsOf3 = 0; teamsOf3 <= playerCount ~/ 3; teamsOf3++) {
      final remaining = playerCount - (3 * teamsOf3);
      if (remaining < 0 || remaining.isOdd) {
        continue;
      }
      final teamsOf2 = remaining ~/ 2;
      final teamCount = teamsOf2 + teamsOf3;
      if (teamCount.isOdd) {
        continue;
      }
      candidates.add(TeamTemplate(teamsOf2: teamsOf2, teamsOf3: teamsOf3));
    }

    if (candidates.isEmpty) {
      throw TournamentGenerationException(
        'Impossible de trouver un mix 2/3 valide pour $playerCount joueurs '
        '(2a + 3b = N et nombre total d\'équipes pair).',
      );
    }

    candidates.sort((a, b) {
      final prefCompare = switch (preference) {
        TeamSizePreference.prefer2 => b.teamsOf2.compareTo(a.teamsOf2),
        TeamSizePreference.prefer3 => b.teamsOf3.compareTo(a.teamsOf3),
      };
      if (prefCompare != 0) {
        return prefCompare;
      }
      return a.teamsOf3.compareTo(b.teamsOf3);
    });

    return candidates.first;
  }
}

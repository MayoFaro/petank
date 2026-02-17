import 'package:flutter_test/flutter_test.dart';
import 'package:petank/src/core/models.dart';
import 'package:petank/src/core/team_size_solver.dart';

void main() {
  group('TeamSizeSolver', () {
    const solver = TeamSizeSolver();

    test('N=17 pref2 => 7x2 + 1x3', () {
      final template = solver.solve(
        playerCount: 17,
        preference: TeamSizePreference.prefer2,
      );
      expect(template.teamsOf2, 7);
      expect(template.teamsOf3, 1);
      expect(template.teamCount.isEven, isTrue);
    });

    test('N=17 pref3 => 1x2 + 5x3', () {
      final template = solver.solve(
        playerCount: 17,
        preference: TeamSizePreference.prefer3,
      );
      expect(template.teamsOf2, 1);
      expect(template.teamsOf3, 5);
      expect(template.teamCount.isEven, isTrue);
    });

    test('throws when impossible', () {
      expect(
        () => solver.solve(
          playerCount: 7,
          preference: TeamSizePreference.prefer2,
        ),
        throwsA(isA<TournamentGenerationException>()),
      );
    });
  });
}

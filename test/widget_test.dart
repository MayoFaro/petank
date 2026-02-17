import 'package:flutter_test/flutter_test.dart';

import 'package:petank/src/app.dart';
import 'package:petank/src/state/app_controller.dart';

void main() {
  testWidgets('app shell shows workflow tabs', (WidgetTester tester) async {
    final controller = AppController.test();

    await tester.pumpWidget(PetankApp(controller: controller));

    expect(find.text('Pool'), findsOneWidget);
    expect(find.text('Tournoi'), findsOneWidget);
    expect(find.text('Plan'), findsOneWidget);
    expect(find.text('Tour'), findsOneWidget);
    expect(find.text('Classement'), findsOneWidget);
  });
}

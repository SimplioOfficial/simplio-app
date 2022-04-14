import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simplio_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testing App Performance Tests', () {
    testWidgets('add wallet', (tester) async {
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SimplioApp());
      const switchKey = 'switch_widget';

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('You have no wallet'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));

      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey(switchKey)), findsWidgets);
      await tester.pumpAndSettle();
      //error for tap switch
      //  await tester.tap(find.byKey(const ValueKey(switchKey)));
    });
  });
}

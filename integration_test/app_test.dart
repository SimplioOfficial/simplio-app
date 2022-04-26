import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simplio_app/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Testing App Performance Tests', () {
    testWidgets('add wallet', (tester) async {
      const switchKey = 'switch_widget';
      const keyButtonNext = 'seed_import_button';

      await tester.pumpWidget(const SimplioApp());

      await tester.tap(find.byKey(const ValueKey(keyButtonNext)));

      await tester.pumpAndSettle();
      expect(find.text('You have no wallet'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));

      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey(switchKey)), findsWidgets);

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');
    });
  });
}

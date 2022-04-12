import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simplio_app/main.dart' as app;

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify import seed tab',
=======

import 'package:simplio_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
>>>>>>> origin/Mario_initial_inf
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

<<<<<<< HEAD
          //Verify if Seed title is present
          expect(find.text('Seed'), findsOneWidget);
          expect(find.text('Generated seed'), findsOneWidget);
         });
=======
          // Verify the counter starts at 0.
          expect(find.text('0'), findsOneWidget);

          // Finds the floating action button to tap on.
          final Finder fab = find.byTooltip('Increment');

          // Emulate a tap on the floating action button.
          await tester.tap(fab);

          // Trigger a frame.
          await tester.pumpAndSettle();

          // Verify the counter increments by 1.
          expect(find.text('1'), findsOneWidget);
        });
>>>>>>> origin/Mario_initial_inf
  });
}
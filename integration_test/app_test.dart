import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simplio_app/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          //Verify if Seed title is present
          expect(find.text('Seed'), findsOneWidget);
          expect(find.text('Generated seed'), findsOneWidget);
         });
    });
}
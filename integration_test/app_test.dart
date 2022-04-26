import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simplio_app/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  print("*************** RUNNING SIMPLIO E2E TESTS*****");
  group('end-to-end test', () {
    testWidgets('Simple test for beginning',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          expect(find.text('You have no wallet'), findsOneWidget);
          expect(find.text('Wallets'), findsOneWidget);
        });
  });
}
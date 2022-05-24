import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simplio_app/main.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  testWidgets('screenshot', (WidgetTester tester) async {
    const importRecoverySeedKey = 'manual_seed_import';
    String platformName = '';

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        platformName = "android";
        await binding.convertFlutterSurfaceToImage();
      } else {
        platformName = "ios";
      }
    } else {
      platformName = "web";
    }

    // Build the app.
    await tester.pumpWidget(const SimplioApp());
    // Trigger a frame.
    await tester.pumpAndSettle();
    await binding.takeScreenshot('1-screenshot-$platformName');

    await tester.tap(find.byKey(const ValueKey(importRecoverySeedKey)));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('2-screenshot-$platformName');
  });
}

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
    // Build the app.
    const importRecoverySeedKey = 'manual_seed_import';
    String platformName = '';
    // This is required prior to taking the screenshot (Android only).
    if (!kIsWeb) {
      await binding.convertFlutterSurfaceToImage();

      if (Platform.isAndroid) {
        platformName = "android";
      } else {
        platformName = "ios";
      }
    } else {
      platformName = "web";
    }
    await tester.pumpWidget(const SimplioApp());
    // Trigger a frame.
    await tester.pumpAndSettle();
    await binding.takeScreenshot('1-screenshot-$platformName');

    await tester.tap(find.byKey(const ValueKey(importRecoverySeedKey)));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('2-screenshot-$platformName');
  });
}

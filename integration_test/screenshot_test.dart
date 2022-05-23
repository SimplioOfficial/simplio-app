import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simplio_app/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  testWidgets('screenshot', (WidgetTester tester) async {
    // Build the app.
    const importRecoverySeedKey = 'manual_seed_import';
    // This is required prior to taking the screenshot (Android only).
    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
    }
    await tester.pumpWidget(const SimplioApp());
    // Trigger a frame.
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-1');

    await tester.tap(find.byKey(const ValueKey(importRecoverySeedKey)));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-2');
  });
}
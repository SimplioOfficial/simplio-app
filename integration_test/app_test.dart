import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:simplio_app/main.dart';

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding();

  testWidgets('screenshot', (WidgetTester tester) async {
    const keyButtonNext = 'seed_import_button';
    String platformName = '';

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
        platformName = "android";
      } else {
        platformName = "ios";
      }
    } else {
      platformName = "web";
    }
    await tester.pumpWidget(const SimplioApp());
    // Take the screenshot
    await binding.takeScreenshot('1-screenshot-$platformName');

    await tester.tap(find.byKey(const ValueKey(keyButtonNext)));
    await tester.pumpAndSettle();

    expect(find.text('You have no wallet'), findsOneWidget);
    // Take the screenshot
    await binding.takeScreenshot('screenshot-$platformName');
  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

/// Taps a widget with exact tooltip.
///
/// Examples:
///
///   `Then I tap the button with tooltip "String"`

StepDefinitionGeneric TapWidgetWithTheKey() {
  return when1<String, FlutterWorld>(
    RegExp(
        r'I tap the button with the key: {string}'),
        (key, context) async {
      final finder = find.byValueKey(key);
      await FlutterDriverUtils.tap(
        context.world.driver,
        finder,
      );
    },
  );
}

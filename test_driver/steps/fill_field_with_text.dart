import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

/// Taps a widget with exact tooltip.
///
/// Examples:
///
///   `Then I tap the button with tooltip "String"`

StepDefinitionGeneric FillFieldWithText() {
  return when2<String, String, FlutterWorld>(
    RegExp(
        r'I fill the field {string} within text {string} :'),
        (key, text, context) async {
      final finder = find.byValueKey(key);
      await FlutterDriverUtils.enterText(
          context.world.driver,
          finder,
          text
      );
    },
  );
}

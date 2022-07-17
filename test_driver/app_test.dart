import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/click_button_with_key.dart';
import 'steps/click_button_with_tooltip.dart';

// import 'steps/I_click_plus_step.dart';
// import 'steps/I_see_value_step.dart';
// import 'steps/I_click_subtract.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      StdoutReporter(MessageLevel.error),
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './cucumber-report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..stepDefinitions = [
      tapWidgetWithTooltip(),
      tapWidgetWithTheKey(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..hooks = [AttachScreenshotOnFailedStepHook()]
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
    ..restartAppBetweenScenarios = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}
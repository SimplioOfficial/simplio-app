import 'package:gherkin/gherkin.dart';

class AttachScreenshotOnFailedStepHook extends Hook {
  /// Run after a step has executed
  @override
  Future<void> onAfterStep(
      World world, String step, StepResult stepResult) async {
    if (stepResult.result == StepExecutionResult.fail) {
      world.attach('Some info.', 'text/plain');
      world.attach('{"some", "JSON"}}', 'application/json');
    }
  }
}

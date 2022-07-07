// import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';


class TapTheButtonWithText extends Then1<String> {
  TapTheButtonWithText()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep(string) async {

  }
  @override
  RegExp get pattern => RegExp(r"I tap the button that contains the text {String}");
}

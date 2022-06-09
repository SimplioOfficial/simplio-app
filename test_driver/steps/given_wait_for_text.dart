import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';


class ClickPlus extends Given1<String> {
  ClickPlus()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep(string) async {






  }
  @override
  RegExp get pattern => RegExp(r"I see {String} text");
}

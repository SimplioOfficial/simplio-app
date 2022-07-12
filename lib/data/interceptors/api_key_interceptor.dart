import 'dart:async';

import 'package:chopper/chopper.dart';

class ApiKeyInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    return request.copyWith(
      parameters: <String, String>{
        "code": const String.fromEnvironment('API_KEY'),
      },
    );
  }
}

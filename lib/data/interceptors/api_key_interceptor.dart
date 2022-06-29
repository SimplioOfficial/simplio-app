import 'dart:async';

import 'package:chopper/chopper.dart';

class ApiKeyInterceptor extends RequestInterceptor {
  /// has a stream of requests which failed

  @override
  FutureOr<Request> onRequest(Request request) {
    return request.copyWith(
      parameters: <String, String>{
        "code": "UVPT9GLZKRooypGpg4lHzf6GffCP9TuTXUkrl0weRn4YAzFuuxmjsA==",
      },
    );
  }
}

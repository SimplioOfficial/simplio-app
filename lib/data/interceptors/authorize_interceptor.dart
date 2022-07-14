import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/http_clients/secured_http_client.dart';

class AuthorizeInterceptor extends RequestInterceptor {
  final AuthTokenStorage authTokenStorage;

  AuthorizeInterceptor({
    required this.authTokenStorage,
  });

  @override
  FutureOr<Request> onRequest(Request request) {
    final authToken = authTokenStorage.get();

    return request.copyWith(headers: {
      "Authorization": "${authToken.tokenType} ${authToken.accessToken}",
    });
  }
}

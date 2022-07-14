import 'dart:async';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/http_clients/secured_http_client.dart';
import 'package:simplio_app/data/model/auth_token.dart';
import 'package:simplio_app/data/services/refresh_token_service.dart';

class RefreshTokenAuthenticator extends Authenticator {
  final AuthTokenStorage authTokenStorage;
  final RefreshTokenService refreshTokenService;

  RefreshTokenAuthenticator({
    required this.authTokenStorage,
    required this.refreshTokenService,
  });

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      final refreshToken = _loadRefreshToken();
      final authToken = await _refreshToken(refreshToken);

      return request.copyWith(headers: {
        ...request.headers,
        "Authorization": "${authToken.tokenType} ${authToken.accessToken}",
      });
    }

    return null;
  }

  Future<AuthToken> _refreshToken(String refreshToken) async {
    try {
      final response = await refreshTokenService.refreshToken(
        RefreshTokenBody(refreshToken: refreshToken),
      );

      final body = response.body;

      if (response.isSuccessful && body != null) {
        final authToken = AuthToken(
          refreshToken: body.refreshToken,
          accessToken: body.accessToken,
          tokenType: body.tokenType,
        );

        await authTokenStorage.save(authToken);

        return authToken;
      }

      throw Exception("Refreshing token has failed");
    } catch (e) {
      throw Exception();
    }
  }

  String _loadRefreshToken() {
    final token = authTokenStorage.get();
    return token.refreshToken;
  }
}

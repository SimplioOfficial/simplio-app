import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/authenticators/refresh_token_authenticator.dart';
import 'package:simplio_app/data/http_clients/http_client.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';
import 'package:simplio_app/data/interceptors/api_key_interceptor.dart';
import 'package:simplio_app/data/interceptors/authorize_interceptor.dart';
import 'package:simplio_app/data/model/auth_token.dart';
import 'package:simplio_app/data/services/password_change_service.dart';
import 'package:simplio_app/data/services/refresh_token_service.dart';

/// Secured Http Client provides with rest endpoints which need
/// Authorization with Bearer + JWT token. Token is refreshed
/// in Authenticator that handles storage and service that
/// calls defined endpoint for refreshing access token.
class SecuredHttpClient extends HttpClient {
  @override
  final ChopperClient client;

  SecuredHttpClient._(this.client);

  SecuredHttpClient.builder(
    String url, {
    required AuthTokenStorage authTokenStorage,
    required RefreshTokenService refreshTokenService,
  }) : this._(
          ChopperClient(
            baseUrl: url,
            converter: JsonSerializableConverter({
              ...PasswordChangeService.converter(),
            }),
            authenticator: RefreshTokenAuthenticator(
              authTokenStorage: authTokenStorage,
              refreshTokenService: refreshTokenService,
            ),
            interceptors: [
              ApiKeyInterceptor(),
              AuthorizeInterceptor(authTokenStorage: authTokenStorage),
            ],
            services: [
              PasswordChangeService.create(),
            ],
          ),
        );
}

/// Common interface for Storing Authentication Tokens
abstract class AuthTokenStorage {
  Future<void> save(AuthToken authToken);
  AuthToken get();
}

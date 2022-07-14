import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/http_clients/http_client.dart';
import 'package:simplio_app/data/interceptors/api_key_interceptor.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';
import 'package:simplio_app/data/services/password_reset_service.dart';
import 'package:simplio_app/data/services/sign_in_service.dart';
import 'package:simplio_app/data/services/sign_up_service.dart';
import 'package:simplio_app/data/services/refresh_token_service.dart';

class PublicHttpClient extends HttpClient {
  @override
  final ChopperClient client;

  PublicHttpClient._(this.client);

  PublicHttpClient.builder(
    String url,
  ) : this._(ChopperClient(
          baseUrl: url,
          converter: JsonSerializableConverter({
            ...SignInService.converter(),
            ...SignUpService.converter(),
            ...RefreshTokenService.converter(),
            ...PasswordResetService.converter(),
          }),
          interceptors: [
            ApiKeyInterceptor(),
          ],
          services: [
            SignInService.create(),
            SignUpService.create(),
            RefreshTokenService.create(),
            PasswordResetService.create(),
          ],
        ));
}

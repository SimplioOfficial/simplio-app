import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/authenticators/refresh_token_authenticator.dart';
import 'package:simplio_app/data/http_clients/http_client.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';

class SecuredHttpClient extends HttpClient {
  @override
  final ChopperClient client;

  SecuredHttpClient._(this.client);

  SecuredHttpClient.builder(
    String url, {
    required AccountDbProvider storage,
  }) : this._(
          ChopperClient(
            baseUrl: url,
            converter: const JsonSerializableConverter({}),
            authenticator: RefreshTokenAuthenticator(url, storage: storage),
            interceptors: [],
            services: [],
          ),
        );
}

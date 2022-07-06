import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/http_clients/http_client.dart';
import 'package:simplio_app/data/interceptors/api_key_interceptor.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';
import 'package:simplio_app/data/services/auth_service.dart';

class PublicHttpClient extends HttpClient {
  @override
  final ChopperClient client;

  PublicHttpClient._(this.client);

  PublicHttpClient.builder(
    String url,
  ) : this._(ChopperClient(
          baseUrl: url,
          converter: JsonSerializableConverter({
            ...AuthService.converter(),
          }),
          interceptors: [
            ApiKeyInterceptor(),
          ],
          services: [
            AuthService.create(),
          ],
        ));
}

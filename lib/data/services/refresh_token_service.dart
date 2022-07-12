import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';

part 'refresh_token_service.chopper.dart';
part 'refresh_token_service.g.dart';

@ChopperApi(baseUrl: '/users/token')
abstract class RefreshTokenService extends ChopperService {
  static RefreshTokenService create() => _$RefreshTokenService();
  static FactoryConvertMap converter() => {
        RefreshTokenResponse: RefreshTokenResponse.fromJson,
      };

  @Post(path: '/refresh')
  Future<Response<RefreshTokenResponse>> refreshToken(
    @Body() RefreshTokenBody body,
  );
}

@JsonSerializable()
class RefreshTokenBody {
  final String refreshToken;

  RefreshTokenBody({
    required this.refreshToken,
  });

  factory RefreshTokenBody.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenBodyToJson(this);
}

@JsonSerializable()
class RefreshTokenResponse {
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String idToken;

  const RefreshTokenResponse({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.idToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}

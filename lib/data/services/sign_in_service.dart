import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';

part 'sign_in_service.chopper.dart';
part 'sign_in_service.g.dart';

@ChopperApi(baseUrl: '/users/token')
abstract class SignInService extends ChopperService {
  static SignInService create() => _$SignInService();
  static FactoryConvertMap converter() => {
        SignInResponse: SignInResponse.fromJson,
      };

  @Post(path: '/issue')
  Future<Response<SignInResponse>> signIn(
    @Body() SignInBody body,
  );
}

@JsonSerializable()
class SignInBody {
  final String email;
  final String password;

  SignInBody({
    required this.email,
    required this.password,
  });

  factory SignInBody.fromJson(Map<String, dynamic> json) =>
      _$SignInBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignInBodyToJson(this);
}

@JsonSerializable()
class SignInResponse {
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String idToken;

  const SignInResponse({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.idToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

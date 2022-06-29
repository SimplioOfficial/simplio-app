import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';

part 'auth_service.chopper.dart';
part 'auth_service.g.dart';

@ChopperApi(baseUrl: '/users')
abstract class AuthService extends ChopperService {
  static AuthService create() => _$AuthService();
  static FactoryConvertMap converter() => {
        SignInResponse: SignInResponse.fromJson,
        SignUpResponse: SignUpResponse.fromJson,
      };

  @Post(path: '/token/issue')
  Future<Response<SignInResponse>> signIn(
    @Body() SignInBody body,
  );

  @Post(path: '/account')
  Future<Response<SignUpResponse>> signUp(
    @Body() SignUpBody body,
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

@JsonSerializable()
class SignUpBody {
  final String email;
  final String password;

  const SignUpBody({
    required this.email,
    required this.password,
  });

  factory SignUpBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);
}

@JsonSerializable()
class SignUpResponse {
  final String userId;

  const SignUpResponse({
    required this.userId,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

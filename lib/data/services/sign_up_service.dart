import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';

part 'sign_up_service.chopper.dart';
part 'sign_up_service.g.dart';

@ChopperApi(baseUrl: '/users')
abstract class SignUpService extends ChopperService {
  static SignUpService create() => _$SignUpService();
  static FactoryConvertMap converter() => {
        SignUpResponse: SignUpResponse.fromJson,
      };

  @Post(path: '/account')
  Future<Response<SignUpResponse>> signUp(
    @Body() SignUpBody body,
  );
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

import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';

part 'password_reset_service.chopper.dart';
part 'password_reset_service.g.dart';

@ChopperApi(baseUrl: '/users/account')
abstract class PasswordResetService extends ChopperService {
  static PasswordResetService create() => _$PasswordResetService();
  static FactoryConvertMap converter() => {};

  @Post(path: '/reset-password')
  Future<Response<void>> resetPassword(
    @Body() PasswordResetBody body,
  );
}

@JsonSerializable()
class PasswordResetBody {
  final String email;

  PasswordResetBody({
    required this.email,
  });

  factory PasswordResetBody.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetBodyToJson(this);
}

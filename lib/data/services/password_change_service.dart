import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplio_app/data/http_clients/json_serializable_convertor.dart';

part 'password_change_service.chopper.dart';
part 'password_change_service.g.dart';

@ChopperApi(baseUrl: '/users/account')
abstract class PasswordChangeService extends ChopperService {
  static PasswordChangeService create() => _$PasswordChangeService();
  static FactoryConvertMap converter() => {};

  @Put(path: '/change-password')
  Future<Response<void>> changePassword(
    @Body() PasswordChangeBody body,
  );
}

@JsonSerializable()
class PasswordChangeBody {
  final String oldPassword;
  final String newPassword;

  PasswordChangeBody({
    required this.oldPassword,
    required this.newPassword,
  });

  factory PasswordChangeBody.fromJson(Map<String, dynamic> json) =>
      _$PasswordChangeBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordChangeBodyToJson(this);
}

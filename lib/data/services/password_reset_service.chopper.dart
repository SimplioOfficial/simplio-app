// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PasswordResetService extends PasswordResetService {
  _$PasswordResetService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PasswordResetService;

  @override
  Future<Response<void>> resetPassword(PasswordResetBody body) {
    final $url = '/users/account/reset-password';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<void, void>($request);
  }
}

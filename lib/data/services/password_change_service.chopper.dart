// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_change_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PasswordChangeService extends PasswordChangeService {
  _$PasswordChangeService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PasswordChangeService;

  @override
  Future<Response<void>> changePassword(PasswordChangeBody body) {
    final $url = '/users/account/change-password';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<void, void>($request);
  }
}

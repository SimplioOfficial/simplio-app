// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$SignUpService extends SignUpService {
  _$SignUpService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SignUpService;

  @override
  Future<Response<SignUpResponse>> signUp(SignUpBody body) {
    final $url = '/users/account';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SignUpResponse, SignUpResponse>($request);
  }
}

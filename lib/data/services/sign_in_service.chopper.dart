// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$SignInService extends SignInService {
  _$SignInService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SignInService;

  @override
  Future<Response<SignInResponse>> signIn(SignInBody body) {
    final $url = '/users/token/issue';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SignInResponse, SignInResponse>($request);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$RefreshTokenService extends RefreshTokenService {
  _$RefreshTokenService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RefreshTokenService;

  @override
  Future<Response<RefreshTokenResponse>> refreshToken(RefreshTokenBody body) {
    final $url = '/users/token/refresh';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<RefreshTokenResponse, RefreshTokenResponse>($request);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInBody _$SignInBodyFromJson(Map<String, dynamic> json) => SignInBody(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInBodyToJson(SignInBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      tokenType: json['tokenType'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as int,
      idToken: json['idToken'] as String,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'tokenType': instance.tokenType,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'idToken': instance.idToken,
    };

SignUpBody _$SignUpBodyFromJson(Map<String, dynamic> json) => SignUpBody(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpBodyToJson(SignUpBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

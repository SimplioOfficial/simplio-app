// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_change_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordChangeBody _$PasswordChangeBodyFromJson(Map<String, dynamic> json) =>
    PasswordChangeBody(
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$PasswordChangeBodyToJson(PasswordChangeBody instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };

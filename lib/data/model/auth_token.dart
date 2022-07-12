import 'package:hive_flutter/adapters.dart';

part 'auth_token.g.dart';

@HiveType(typeId: 7)
class AuthToken extends HiveObject {
  @HiveField(0)
  final String refreshToken;

  @HiveField(1)
  final String accessToken;

  @HiveField(2)
  final String tokenType;

  AuthToken({
    required this.refreshToken,
    required this.accessToken,
    required this.tokenType,
  });
}

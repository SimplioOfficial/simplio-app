import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/mixins/jwt_mixin.dart';

part 'auth_token.g.dart';

// class AccessToken extends Equatable with JwtMixin {
//   final String tokenType;
//   final String token;
//
//   const AccessToken({
//     required this.tokenType,
//     required this.token,
//   });
//
//   @override
//   List<Object?> get props => [
//         tokenType,
//         token,
//       ];
//
//   Map<String, dynamic> payload() {
//     return parseJwt(token);
//   }
// }
//
// class AuthToken extends Equatable {
//   final String refreshToken;
//   final AccessToken accessToken;
//
//   const AuthToken({
//     required this.refreshToken,
//     required this.accessToken,
//   });
//
//   @override
//   List<Object?> get props => [
//         refreshToken,
//         accessToken,
//       ];
// }

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

  // TODO: remove when possible

  // AuthToken(
  //   this.refreshToken,
  //   this.accessToken,
  //   this.tokenType,
  // );
  //
  // AuthToken.builder({
  //   required String refreshToken,
  //   required String accessToken,
  //   required String tokenType,
  // }) : this(
  //         refreshToken,
  //         accessToken,
  //         tokenType,
  //       );
}

import 'package:simplio_app/data/http_clients/secured_http_client.dart';
import 'package:simplio_app/data/mixins/jwt_mixin.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/auth_token.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/services/password_reset_service.dart';
import 'package:simplio_app/data/services/sign_in_service.dart';
import 'package:simplio_app/data/services/password_change_service.dart';
import 'package:simplio_app/data/services/sign_up_service.dart';

class AuthRepository with JwtMixin {
  final AccountDbProvider _db;
  final AuthTokenStorage _authTokenStorage;
  final SignInService _signInService;
  final SignUpService _signUpService;
  final PasswordChangeService _passwordChangeService;
  final PasswordResetService _passwordResetService;

  const AuthRepository._(
    this._db,
    this._authTokenStorage,
    this._signInService,
    this._signUpService,
    this._passwordChangeService,
    this._passwordResetService,
  );

  const AuthRepository.builder({
    required AccountDbProvider db,
    required AuthTokenStorage authTokenStorage,
    required SignInService signInService,
    required SignUpService signUpService,
    required PasswordChangeService passwordChangeService,
    required PasswordResetService passwordResetService,
  }) : this._(
          db,
          authTokenStorage,
          signInService,
          signUpService,
          passwordChangeService,
          passwordResetService,
        );

  Future<AuthRepository> init() async {
    await _db.init();

    return this;
  }

  Account? lastSignedIn() {
    return _db.last();
  }

  Future<void> signUp(String email, String password) async {
    final response = await _signUpService.signUp(SignUpBody(
      email: email,
      password: password,
    ));

    if (response.isSuccessful) {
      return;
    }

    throw Exception("Sign up has failed");
  }

  Future<Account> signIn(String login, String password) async {
    try {
      final response = await _signInService
          .signIn(SignInBody(email: login, password: password));

      final body = response.body;

      if (response.isSuccessful && body != null) {
        final decodedIdToken = parseJwt(body.idToken);

        decodedIdToken.containsKey("name");
        if (!decodedIdToken.containsKey('name')) {
          throw Exception("Provided IdToken has missing 'name' field.");
        }

        await _authTokenStorage.save(AuthToken(
          refreshToken: body.refreshToken,
          tokenType: body.tokenType,
          accessToken: body.accessToken,
        ));

        final userId = decodedIdToken['name'];
        final acc = _db.get(userId);

        if (acc != null) {
          return await _db.save(acc.copyWith(
            signedIn: DateTime.now(),
          ));
        }

        return await _db.save(Account.builder(
          id: userId,
          secret: LockableSecret.generate(),
          refreshToken: body.refreshToken,
          signedIn: DateTime.now(),
        ));
      }

      // TODO: Provide with a custom error
      throw Exception(response.error);
    } catch (e) {
      throw Exception("Sign in has failed");
    }
  }

  Future<void> signOut({required String accountId}) async {
    final Account? account = _db.get(accountId);

    if (account != null) {
      await _db.save(account.copyWith(
        signedIn: DateTime.fromMillisecondsSinceEpoch(0),
      ));
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    final response =
        await _passwordChangeService.changePassword(PasswordChangeBody(
      oldPassword: oldPassword,
      newPassword: newPassword,
    ));

    if (response.isSuccessful) return;

    throw Exception("Changing a password has failed");
  }

  Future<void> resetPassword(String email) async {
    final response = await _passwordResetService.resetPassword(
      PasswordResetBody(email: email),
    );

    if (response.isSuccessful) return;

    throw Exception("Resetting a password has failed");
  }
}

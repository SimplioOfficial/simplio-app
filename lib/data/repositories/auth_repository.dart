import 'package:simplio_app/data/mixins/jwt_mixin.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/services/auth_service.dart';

class AuthRepository with JwtMixin {
  final AccountDbProvider _db;
  final AuthService _apiService;

  const AuthRepository._(
    this._db,
    this._apiService,
  );

  const AuthRepository.builder({
    required AccountDbProvider db,
    required AuthService authService,
  }) : this._(
          db,
          authService,
        );

  Future<AuthRepository> init() async {
    await _db.init();

    return this;
  }

  Account? lastSignedIn() {
    return _db.last();
  }

  // TODO: Sign In implementation is only temporary.
  Future<Account> signIn(String login, String password) async {
    // TODO: remove delay on final implementation.
    try {
      final response = await _apiService
          .signIn(SignInBody(email: login, password: password));

      final body = response.body;

      if (response.isSuccessful && body != null) {
        final decodedIdToken = parseJwt(body.idToken);

        decodedIdToken.containsKey("name");
        if (!decodedIdToken.containsKey('name')) {
          throw Exception("Provided IdToken has missing 'name' field.");
        }

        final userId = decodedIdToken['name'];
        final acc = _db.get(userId);
        if (acc != null) {
          final updatedAccount = acc.copyWith(
            accessToken: body.accessToken,
            refreshToken: body.refreshToken,
          );

          await _db.save(updatedAccount);

          return updatedAccount;
        }

        final newAccount = Account.builder(
          id: userId,
          secret: LockableSecret.generate(),
          refreshToken: body.refreshToken,
          signedIn: DateTime.now(),
        );

        await _db.save(newAccount);

        return newAccount;
      }

      throw Exception(response.error);
    } catch (e) {
      print("There was an error.");
      print(e.toString());
      throw Exception("Sign in has failed");
    }

    // await Future.delayed(const Duration(seconds: 3));
    //
    // final Account? account = _db.get(login);
    //
    // if (account != null) {
    //   return _db.save(account.copyWith(
    //     signedIn: DateTime.now(),
    //   ));
    // }
    //
    // final AccountWallet testWallet = AccountWallet.builder(
    //   name: 'Generated wallet',
    //   accountId: login,
    //   walletType: AccountWalletTypes.hdWallet,
    //   seed: LockableSeed.from(
    //     mnemonic: 'not your keys not your coins',
    //     isImported: false,
    //     isLocked: false,
    //     isBackedUp: false,
    //   ),
    //   updatedAt: DateTime.now(),
    // );
    //
    // return _db.save(Account.builder(
    //   id: login,
    //   secret: LockableSecret.generate(),
    //   refreshToken: '',
    //   signedIn: DateTime.now(),
    //   wallets: <AccountWallet>[testWallet],
    // ));
  }

  Future<void> signOut({required String accountId}) async {
    final Account? account = _db.get(accountId);

    if (account != null) {
      await _db.save(account.copyWith(
        signedIn: DateTime.fromMillisecondsSinceEpoch(0),
      ));
    }
  }
}

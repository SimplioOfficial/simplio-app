import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';

class AuthRepository {
  final AccountDbProvider _db;

  const AuthRepository._(this._db);

  const AuthRepository.builder({
    required AccountDbProvider db,
  }) : this._(db);

  Future<AuthRepository> init() async {
    await _db.init();

    return this;
  }

  Account? lastSignedIn() {
    return _db.last();
  }

  // TODO: Sign In implementation is only temporary.
  Future<Account> signIn(String id, String password) async {
    // TODO: remove delay on final implementation.
    await Future.delayed(const Duration(seconds: 3));

    final Account? account = _db.get(id);

    if (account != null) {
      return _db.save(account.copyWith(
        signedIn: DateTime.now(),
      ));
    }

    final AccountWallet testWallet = AccountWallet.builder(
      name: 'Generated wallet',
      accountId: id,
      walletType: AccountWalletTypes.hdWallet,
      seed: LockableSeed.from(
        mnemonic: 'not your keys not your coins',
        isImported: false,
        isLocked: false,
        isBackedUp: false,
      ),
      updatedAt: DateTime.now(),
    );
    return _db.save(Account.builder(
      id: id,
      secret: LockableSecret.generate(),
      refreshToken: '',
      signedIn: DateTime.now(),
      wallets: <AccountWallet>[testWallet],
    ));
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

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

  Account? lastLoggedIn() {
    return _db.last();
  }

  // TODO: Login implementation is only temporary.
  Future<Account> login(String id, String password) async {
    final Account? account = _db.get(id);

    if (account != null) {
      return _db.save(account.copyWith(
        lastLogin: DateTime.now(),
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
      lastLogin: DateTime.now(),
      wallets: <AccountWallet>[testWallet],
    ));
  }

  Future<void> logout({required String accountId}) async {
    final Account? account = _db.get(accountId);

    if (account != null) {
      await _db.save(account.copyWith(
        lastLogin: DateTime.fromMillisecondsSinceEpoch(0),
      ));
    }
  }
}

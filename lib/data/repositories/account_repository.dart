import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/data/model/seed.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';

class AccountRepository {
  final AccountDbProvider _db;

  const AccountRepository._(this._db);

  const AccountRepository.builder({
    required AccountDbProvider db,
  }) : this._(db);

  Future<AccountRepository> init() async {
    await _db.init();

    return this;
  }

  Account? latest() {
    return _db.last();
  }

  Future<Account> save(Account account) async {
    return await _db.save(account);
  }

  Account? get(String id) {
    return _db.get(id);
  }

  Future<Account> login(String id, String password) async {
    final Account? account = _db.get(id);

    if (account != null) return account;

    //  login here

    // TODO: Generating account wallet is only temporary. Please remove it when no longer necessary.
    final AccountWallet testWallet = AccountWallet.builder(
      name: 'Generated wallet',
      accountId: id,
      walletType: AccountWalletTypes.hdWallet,
      seed: const Seed(
        mnemonic: 'not your keys not your coins',
        imported: false,
      ),
      updatedAt: DateTime.now(),
    );

    return _db.save(Account.builder(
        id: id,
        secret: LockableSecret.generate(),
        refreshToken: '',
        lastLogin: DateTime.now(),
        defaultWallet: testWallet.uuid,
        wallets: <AccountWallet>[testWallet]));
  }

  Future<void> logout(Account account) async {
    await _db.save(account.copyWith(
      lastLogin: DateTime.fromMillisecondsSinceEpoch(0),
    ));
  }
}

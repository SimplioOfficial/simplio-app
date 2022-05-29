import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';

class AccountDbProvider {
  static const accountBoxName = 'accountBox';
  late final Box<AccountLocal> _accountBox;

  AccountDbProvider();

  Future<AccountDbProvider> init() async {
    Hive.registerAdapter(AccountLocalAdapter());
    Hive.registerAdapter(AccountWalletLocalAdapter());
    Hive.registerAdapter(AccountWalletTypesAdapter());
    Hive.registerAdapter(AccountSettingsLocalAdapter());
    Hive.registerAdapter(ThemeModesAdapter());

    _accountBox = await Hive.openBox<AccountLocal>(accountBoxName);

    // TODO - remove. Clear is for testing purposes only.
    // await _accountBox.clear();

    return this;
  }

  Account? get(String id) {
    try {
      final AccountLocal? account = _accountBox.get(id);

      return account != null ? _to(account) : null;
    } on Exception {
      return null;
    }
  }

  Future<Account> save(Account account) async {
    final _ = await _accountBox.put(account.id, _from(account));

    return account;
  }

  Account? last() {
    try {
      final lastLocal = _accountBox.values.toList().reduce(
          (acc, curr) => acc.lastLogin.isAfter(curr.lastLogin) ? acc : curr);

      if (lastLocal.lastLogin
          .isAtSameMomentAs(DateTime.fromMillisecondsSinceEpoch(0))) {
        throw Exception("There's no logged in account");
      }

      return _to(lastLocal);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  AccountLocal _from(Account account) {
    return AccountLocal(
      id: account.id,
      secret: account.secret.toString(),
      refreshToken: account.refreshToken,
      lastLogin: account.lastLogin,
      settings: AccountSettingsLocal(
        themeMode: account.settings.themeMode,
      ),
      wallets: account.wallets
          .map((w) => AccountWalletLocal(
                uuid: w.uuid,
                name: w.name,
                accountId: w.accountId,
                mnemonic: w.seed.toString(),
                isImported: w.seed.isImported,
                isBackedUp: w.seed.isBackedUp,
                walletType: w.walletType,
                updatedAt: w.updatedAt,
              ))
          .toList(),
    );
  }

  Account _to(AccountLocal accountLocal) {
    return Account.builder(
      id: accountLocal.id,
      secret: LockableSecret.from(secret: accountLocal.secret),
      refreshToken: accountLocal.refreshToken,
      lastLogin: accountLocal.lastLogin,
      wallets: accountLocal.wallets
          .map((w) => AccountWallet.builder(
                uuid: w.uuid,
                name: w.name,
                accountId: w.accountId,
                walletType: w.walletType,
                seed: LockableSeed.from(
                  mnemonic: w.mnemonic,
                  isImported: w.isImported,
                  isBackedUp: w.isBackedUp,
                ),
                updatedAt: w.updatedAt,
              ))
          .toList(),
      settings: AccountSettings.builder(
        themeMode: accountLocal.settings.themeMode,
      ),
    );
  }
}

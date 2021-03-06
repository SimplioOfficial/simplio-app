import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/data/providers/box_provider.dart';

class AccountDbProvider extends BoxProvider<AccountLocal> {
  static final AccountDbProvider _instance = AccountDbProvider._();

  @override
  final String boxName = 'accountBox';

  AccountDbProvider._();

  factory AccountDbProvider() {
    return _instance;
  }

  @override
  void registerAdapters() {
    Hive.registerAdapter(AccountLocalAdapter());
    Hive.registerAdapter(AccountWalletLocalAdapter());
    Hive.registerAdapter(AccountWalletTypesAdapter());
    Hive.registerAdapter(AccountSettingsLocalAdapter());
    Hive.registerAdapter(ThemeModeLocalAdapter());
  }

  Account? get(String id) {
    try {
      final AccountLocal? account = box.get(id);
      return account != null ? _mapTo(account) : null;
    } catch (_) {
      return null;
    }
  }

  Future<Account> save(Account account) async {
    await box.put(account.id, _mapFrom(account));
    return account;
  }

  Account? last() {
    try {
      final localAccount = box.values.reduce(
        (acc, curr) => acc.signedIn.isAfter(curr.signedIn) ? acc : curr,
      );

      final isZero = localAccount.signedIn.isAtSameMomentAs(
        DateTime.fromMillisecondsSinceEpoch(0),
      );
      if (isZero) return null;

      return _mapTo(localAccount);
    } catch (_) {
      return null;
    }
  }

  ThemeMode _mapFromTheme(ThemeModeLocal themeLocal) {
    switch (themeLocal) {
      case ThemeModeLocal.dark:
        return ThemeMode.dark;
      case ThemeModeLocal.light:
        return ThemeMode.light;
      case ThemeModeLocal.system:
        return ThemeMode.system;
    }
  }

  ThemeModeLocal _mapToTheme(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.dark:
        return ThemeModeLocal.dark;
      case ThemeMode.light:
        return ThemeModeLocal.light;
      case ThemeMode.system:
        return ThemeModeLocal.system;
    }
  }

  AccountLocal _mapFrom(Account account) {
    return AccountLocal(
      id: account.id,
      secret: account.secret.toString(),
      refreshToken: account.refreshToken,
      signedIn: account.signedIn,
      settings: AccountSettingsLocal(
        themeMode: _mapToTheme(account.settings.themeMode),
        languageCode: account.settings.locale.languageCode,
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

  Account _mapTo(AccountLocal accountLocal) {
    return Account.builder(
      id: accountLocal.id,
      secret: LockableSecret.from(secret: accountLocal.secret),
      refreshToken: accountLocal.refreshToken,
      signedIn: accountLocal.signedIn,
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
        themeMode: _mapFromTheme(accountLocal.settings.themeMode),
        locale: Locale(accountLocal.settings.languageCode),
      ),
    );
  }
}

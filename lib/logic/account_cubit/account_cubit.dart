import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository _accountRepository;
  final AssetWalletRepository _assetWalletRepository;

  AccountCubit._(
    this._accountRepository,
    this._assetWalletRepository,
  ) : super(const AccountState.initial());

  AccountCubit.builder({
    required AccountRepository accountRepository,
    required AssetWalletRepository assetWalletRepository,
  }) : this._(accountRepository, assetWalletRepository);

  Account? loadAccount(String accountId) {
    final Account? account = _accountRepository.get(accountId);

    if (account == null) return null;

    final accountWallet = account.accountWallet;
    List<AssetWallet> assetWallets = const [];

    if (accountWallet != null) {
      assetWallets = _assetWalletRepository.load(accountWallet.uuid);
    }

    emit(AccountState.value(
      account: account,
      assetWallets: assetWallets,
    ));

    return account;
  }

  void clearAccount() {
    emit(AccountState.value(
      account: Account.builder(
          id: '0',
          secret: LockableSecret.from(secret: ''),
          refreshToken: '',
          signedIn: DateTime(0),
          settings: state.account?.settings ?? const AccountSettings.preset()),
      assetWallets: const [],
    ));
  }

  Future<void> updateAccount(Account account) async {
    final savedAccount = await _accountRepository.save(account);

    emit(state.copyWith(account: savedAccount));
  }

  // prepared for future - currently not used
  Future<void> updatePin({required List<int> pin, List<int>? oldPin}) async {
    if (state.account != null) {
      LockableSecret secret;
      if (state.account!.secret.isLocked && oldPin != null) {
        var unlockedSecret = state.account!.secret.unlock(oldPin.join());
        secret = LockableSecret.from(secret: unlockedSecret).lock(pin.join());
      } else {
        secret = state.account!.secret.lock(pin.join());
      }

      var account = Account.builder(
          id: state.account!.id,
          secret: secret,
          accessToken: state.account!.accessToken,
          refreshToken: state.account!.refreshToken,
          signedIn: state.account!.signedIn,
          settings: state.account!.settings,
          wallets: state.account!.wallets);

      return updateAccount(account);
    }
  }

  Future<void> setLanguage(String languageCode) async {
    var account = state.account?.copyWith(
        settings:
            state.account?.settings.copyFrom(locale: Locale(languageCode)));

    if (account != null) return updateAccount(account);
  }

  Future<void> setTheme(ThemeMode theme) async {
    var account = state.account?.copyWith(
        settings: state.account?.settings.copyFrom(themeMode: theme));

    if (account != null) return updateAccount(account);
  }

  Future<void> enableAssetWallet(String assetId) async {
    final accountWallet = state.account?.accountWallet;
    if (accountWallet == null) return;

    await _assetWalletRepository.enable(accountWallet.uuid, assetId);
    final assetWallets = _assetWalletRepository.load(accountWallet.uuid);

    emit(state.copyWith(assetWallets: assetWallets));
  }

  Future<void> disableAssetWallet(String assetId) async {
    final accountWallet = state.account?.accountWallet;
    if (accountWallet == null) return;

    await _assetWalletRepository.disable(accountWallet.uuid, assetId);
    final assetWallets = _assetWalletRepository.load(accountWallet.uuid);

    emit(state.copyWith(assetWallets: assetWallets));
  }
}

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

    if (state.account?.id == accountId) return state.account;

    if (account == null) {
      // // clear account state after logout
      emit(const AccountState.value(
        account: null,
        assetWallets: [],
      ));
      return null;
    }

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

  Future<void> updateAccount(Account account) async {
    final savedAccount = await _accountRepository.save(account);

    emit(state.copyWith(account: savedAccount));
  }

  Future<void> setLanguage(String languageCode) async {
    var accountSettings = AccountSettings.builder(
      themeMode: state.account?.settings.themeMode ??
          const AccountSettings.preset().themeMode,
      locale: Locale(languageCode),
    );
    var account = state.account?.copyWith(settings: accountSettings);

    return updateAccount(account!);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';

class LogicUtils {
  static void updateAccountSeed(BuildContext context, String seed) {
    var account = context.read<AccountCubit>().state.account;

    if (account != null) {
      var accountWallet = account.accountWallet;

      if (accountWallet != null) {
        accountWallet = AccountWallet.builder(
            name: accountWallet.name,
            accountId: accountWallet.accountId,
            walletType: accountWallet.walletType,
            seed: LockableSeed.from(
                mnemonic: seed,
                isImported: accountWallet.seed.isImported,
                isBackedUp: accountWallet.seed.isBackedUp),
            updatedAt: accountWallet.updatedAt);

        var wallets = account.wallets
            .map((w) => AccountWallet.builder(
                  uuid: w.uuid,
                  name: w.name,
                  accountId: w.accountId,
                  walletType: w.walletType,
                  seed: LockableSeed.from(
                    mnemonic: w.seed.mnemonic,
                    isImported: w.seed.isImported,
                    isBackedUp: w.seed.isBackedUp,
                  ),
                  updatedAt: w.updatedAt,
                ))
            .toList();

        account = Account.builder(
            id: account.id,
            secret: account.secret,
            refreshToken: account.refreshToken,
            lastLogin: account.lastLogin,
            accessToken: account.accessToken,
            settings: account.settings,
            wallets: wallets);

        context.read<AccountCubit>().updateAccount(account);
      }
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/data/repositories/wallet_core_repository.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';
import 'package:simplio_app/logic/wallet_utils.dart';

class WalletCoreBlocListeners {
  var updateAccountAfterWalletCoreUpdated =
  BlocListener<WalletCoreBloc, WalletCoreState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) {
        var account = context
            .read<AccountCubit>()
            .state
            .account;

        if (account != null) {
          var wallets = account.wallets
              .map((w) =>
              AccountWallet.builder(
                uuid: w.uuid,
                name: w.name,
                accountId: w.accountId,
                walletType: w.walletType,
                seed: LockableSeed.from(
                  mnemonic: state.seed,
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
      });

  var updateBalancesAfterWalletCoreUpdated =
  BlocListener<WalletCoreBloc, WalletCoreState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) {
        var accountState = context
            .read<AccountCubit>()
            .state;


        WalletUtils.getAssetBalance(
            assetWallet: widget.assetWallet,
            getAddress: walletCore.getAddress)
            .then((value) {
          totalBalance = value;
          print('71, ${totalBalance}');
        });
      });
}

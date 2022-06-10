import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/wallet_core_repository.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';

class AccountCubitListeners {
  BlocListener<AccountCubit, AccountState> generateSeedAfterAccountCreated =
      BlocListener<AccountCubit, AccountState>(
    listenWhen: (prev, curr) => curr.account?.accountSeed == '',
    listener: (context, state) {
      var seed =
          RepositoryProvider.of<WalletCoreRepository>(context).generateSeed();
      context.read<WalletCoreBloc>().add(WalletCoreSeedSet(seed: seed));
    },
  );

  BlocListener<AccountCubit, AccountState> updateWalletCoreAfterSeedImported =
      BlocListener<AccountCubit, AccountState>(
    listenWhen: (prev, curr) =>
        (prev.account?.accountSeed != curr.account?.accountSeed) &&
        curr.account?.accountSeed != '',
    listener: (context, state) {
      var seed = state.account?.accountSeed;
      if (seed != null) {
        context.read<WalletCoreBloc>().add(WalletCoreSeedSet(seed: seed));
      }
    },
  );
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/logic_utils.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';

class WalletCoreBlocListeners {
  BlocListener<WalletCoreBloc, WalletCoreState>
      updateAccountAfterWalletCoreUpdated =
      BlocListener<WalletCoreBloc, WalletCoreState>(
    listenWhen: (prev, curr) => prev != curr,
    listener: (context, state) =>
        LogicUtils.updateAccountSeed(context, state.seed),
  );
}

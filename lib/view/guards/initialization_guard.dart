import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';

class InitializationGuard extends StatelessWidget {
  final Widget Function(BuildContext context) onInitialized;
  final Widget Function(BuildContext context) onLoading;

  const InitializationGuard({
    Key? key,
    required this.onInitialized,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use chain of BlocBuilder in order to check multiple conditions
    // Like in this example:

    // var blockBuilder1 = BlocBuilder<WalletCoreBloc, WalletCoreState>(
    //     buildWhen: (previous, current) => previous != current,
    //     builder: (BuildContext context, state) {
    //       return state.seed != '' ? onInitialized(context) : onLoading(context);
    //     });
    // var blockBuilder2 = BlocBuilder<WalletCoreBloc, WalletCoreState>(
    //     buildWhen: (previous, current) => previous != current,
    //     builder: (BuildContext context, state) {
    //       return state.seed != '' ? blockBuilder1 : onLoading(context);
    //     });
    // var blockBuilder3 = BlocBuilder<WalletCoreBloc, WalletCoreState>(
    //     buildWhen: (previous, current) => previous != current,
    //     builder: (BuildContext context, state) {
    //       return state.seed != '' ? blockBuilder2 : onLoading(context);
    //     });
    // var blockBuilder4 = BlocBuilder<WalletCoreBloc, WalletCoreState>(
    //     buildWhen: (previous, current) => previous != current,
    //     builder: (BuildContext context, state) {
    //       return state.seed.startsWith('a')
    //           ? blockBuilder3
    //           : onLoading(context);
    //     });

    var walletCoreInitializationGuard =
        BlocBuilder<WalletCoreBloc, WalletCoreState>(
            buildWhen: (previous, current) => previous != current,
            builder: (BuildContext context, state) {
              return state.seed != ''
                  ? onInitialized(context)
                  : onLoading(context);
            });

    return walletCoreInitializationGuard;
  }
}

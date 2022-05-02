import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/trust_wallet_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/asset_wallet_bloc/asset_wallet_bloc.dart';
import 'package:simplio_app/view/routes/home_route.dart';
import 'package:simplio_app/view/widgets/wallet_list_item.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkSeed(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wallets'),
        backgroundColor: Colors.white,
        elevation: 0.4,
        foregroundColor: Colors.black87,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed(
              HomeRoute.assets,
            ),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () => context.read<AccountBloc>().add(AccountRemoved()),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listenWhen: (previous, current) {
          return previous.accountWallet != current.accountWallet;
        },
        listener: (context, state) {
          final acc = state.accountWallet;
          if (acc != null) {
            context
                .read<AssetWalletBloc>()
                .add(AssetWalletLoaded(accountWalletId: acc.uuid));
          }
        },
        child: BlocBuilder<AssetWalletBloc, AssetWalletState>(
          builder: (context, state) {
            var enabled = state.enabled;

            return Container(
              child: enabled.isEmpty
                  ? const Center(
                      child: Text(
                        'You have no wallet',
                        style: TextStyle(color: Colors.black26),
                      ),
                    )
                  : ListView.builder(
                      itemCount: enabled.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        final AssetWallet wallet = enabled[i];
                        HDWallet? trustWallet =
                            context.read<TrustWalletRepository>().trustWallet;

                        if (trustWallet != null) {
                          print('74 ${trustWallet.mnemonic()}');
                          return WalletListItem(
                            key: Key(wallet.assetId),
                            assetWallet: wallet,
                            trustWallet: trustWallet,
                            onTap: () => Navigator.of(context)
                                .pushNamed(HomeRoute.wallet, arguments: wallet),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  _checkSeed(BuildContext context) {
    Future.delayed(Duration.zero, () {
      HDWallet? trustWallet = context.read<TrustWalletRepository>().trustWallet;
      // if trust wallet is not initialized navigate to seed generation
      if (trustWallet == null) {
        Navigator.of(
          context,
        ).popAndPushNamed(HomeRoute.initialSettings);
      } else {
        print('102 ${trustWallet.mnemonic()}');
      }
    });
  }
}

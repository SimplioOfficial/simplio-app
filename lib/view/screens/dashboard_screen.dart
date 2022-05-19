import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/logic/asset_wallet_bloc/asset_wallet_bloc.dart';
import 'package:simplio_app/view/router/app_router.dart';
import 'package:simplio_app/view/widgets/wallet_list_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Wallets'),
          backgroundColor: Colors.white,
          elevation: 0.4,
          foregroundColor: Colors.black87,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                      AppRouter.walletProjects,
                    ),
                icon: const Icon(Icons.add)),
          ],
        ),
        body: BlocBuilder<AssetWalletBloc, AssetWalletState>(
            builder: (context, state) {
          if (state is! AssetWallets) return const Text('No wallets loaded');

          var enabled = state.enabled;

          return Container(
            child: enabled.isEmpty
                ? const Center(
                    child: Opacity(
                        opacity: 0.4,
                        child: Text('You have no wallet',
                            style: TextStyle(color: Colors.black))),
                  )
                : ListView.builder(
                    itemCount: enabled.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      final AssetWallet wallet = enabled[i];

                      return WalletListItem(
                        assetWallet: wallet,
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRouter.wallet, arguments: wallet),
                      );
                    },
                  ),
          );
        }),
      );
}
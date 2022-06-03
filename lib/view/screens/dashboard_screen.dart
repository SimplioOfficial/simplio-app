import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/widgets/wallet_list_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(context.watch<AccountCubit>().state.account?.id ?? ''),
        backgroundColor: Colors.white,
        elevation: 0.4,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'a',
            onPressed: () => Navigator.of(context).pushNamed(
              AuthenticatedRoute.assets,
            ),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'b',
            backgroundColor: Colors.black,
            onPressed: () async {
              context.read<AuthBloc>().add(const GotUnauthenticated());
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<AccountCubit, AccountState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          var enabledAssetWallets = state.enabledAssetWallets;

          return Container(
            child: enabledAssetWallets.isEmpty
                ? const Center(
                    child: Text(
                      'You have no wallet',
                      style: TextStyle(color: Colors.black26),
                    ),
                  )
                : ListView.builder(
                    itemCount: enabledAssetWallets.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      final AssetWallet wallet = enabledAssetWallets[i];

                      return WalletListItem(
                        key: Key(wallet.assetId),
                        assetWallet: wallet,
                        onTap: () => Navigator.of(context).pushNamed(
                            AuthenticatedRoute.wallet,
                            arguments: wallet),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

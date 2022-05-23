import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/view/router/app_router.dart';
import 'package:simplio_app/view/router/home_router.dart';

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
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRouter.assets,
              ),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () =>
                  context.read<AccountBloc>().add(AccountRemoved()),
              child: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Navigator(
          initialRoute: HomeRouter.assets,
          onGenerateRoute: HomeRouter().generateRoute,
        ),
        // body: BlocBuilder<AssetWalletBloc, AssetWalletState>(
        //     builder: (context, state) {
        //   if (state is! AssetWallets) return const Text('No wallets loaded');
        //
        //   var enabled = state.enabled;
        //
        //   return Container(
        //     child: enabled.isEmpty
        //         ? const Center(
        //             child: Text('You have no wallet',
        //                 style: TextStyle(color: Colors.black26)),
        //           )
        //         : ListView.builder(
        //             itemCount: enabled.length,
        //             itemBuilder: (BuildContext ctx, int i) {
        //               final AssetWallet wallet = enabled[i];
        //
        //               return WalletListItem(
        //                 assetWallet: wallet,
        //                 onTap: () => Navigator.of(context)
        //                     .pushNamed(AppRouter.wallet, arguments: wallet),
        //               );
        //             },
        //           ),
        //   );
        // }),
      );
}

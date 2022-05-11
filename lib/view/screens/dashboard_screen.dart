import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(
            AppRouter.assets,
          ),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
          if (state is! Wallets) return const Text('No wallets loaded');

          var enabled = state.enabled;

          return Container(
            child: enabled.isEmpty
                ? const Center(
                    child: Text('You have no wallet',
                        style: TextStyle(color: Colors.black26)),
                  )
                : ListView.builder(
                    itemCount: enabled.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      Wallet wallet = enabled[i];

                      return WalletListItem(
                        wallet: wallet,
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRouter.wallet, arguments: wallet),
                      );
                    },
                  ),
          );
        }),
      );
}

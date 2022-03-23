import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';
import 'package:simplio_app/view/widgets/wallet_list_item.dart';
import 'package:simplio_app/view/router/app_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Wallets'),
          backgroundColor: Colors.white,
          elevation: 1,
          foregroundColor: Colors.black87,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                      AppRouter.walletProjects,
                    ),
                icon: const Icon(Icons.add)),
          ],
        ),
        body: BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
          if (state is! Wallets) return const Text('No wallets loaded');

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
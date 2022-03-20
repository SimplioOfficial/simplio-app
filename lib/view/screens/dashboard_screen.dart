import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/wallet/wallet_bloc.dart';
import 'package:simplio_app/view/route/route_manager.dart';
import 'package:simplio_app/view/widgets/wallet_list_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is! Wallets) return const Text('Something went wrong');

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Wallets'),
            backgroundColor: Colors.white,
            elevation: 1,
            foregroundColor: Colors.black87,
            actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteManager.wallets),
                  icon: const Icon(Icons.add)),
            ],
          ),
          body: state.active().isEmpty
              ? const Center(
                  child: Opacity(
                      opacity: 0.4,
                      child: Text('You have no wallet',
                          style: TextStyle(color: Colors.black))),
                )
              : ListView.builder(
                  itemCount: state.active().length,
                  itemBuilder: (BuildContext ctx, int i) {
                    Wallet wallet = state.active()[i];

                    return WalletListItem(
                      wallet: wallet,
                      onTap: () => Navigator.of(context)
                          .pushNamed(RouteManager.wallet, arguments: wallet),
                    );
                  },
                ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/wallet/wallet_bloc.dart';
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
        if (state is Wallets) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Wallets'),
              backgroundColor: Colors.white,
              elevation: 2,
              foregroundColor: Colors.black87,
              actions: [
                BlocListener<WalletBloc, WalletState>(
                  listener: (context, state) {
                    if (state is Wallets) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('A new wallet added'),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(20.0),
                          duration: Duration(
                            milliseconds: 600,
                          )));
                    }
                  },
                  child: IconButton(
                      onPressed: () {
                        var wallet = const Wallet.generate(
                            name: 'Wallet', ticker: 'ticker');

                        context
                            .read<WalletBloc>()
                            .add(AddWallet(wallet: wallet));
                      },
                      icon: const Icon(Icons.add)),
                ),
              ],
            ),
            body: state.all.isEmpty
                ? const Center(
                    child: Opacity(
                        opacity: 0.4,
                        child: Text('You have no wallet',
                            style: TextStyle(color: Colors.black))),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.all.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return WalletListItem(wallet: state.all[i]);
                    },
                  ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletScreen extends StatefulWidget {
  final Wallet wallet;

  const WalletScreen({Key? key, required this.wallet}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletScreen();
}

class _WalletScreen extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    HDWallet? trustWallet =
        (BlocProvider.of<TrustWalletCoreBloc>(context).state as TrustWalletCore)
            .trustWallet;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wallet.project.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.wallet.project.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  trustWallet!
                      .getAddressForCoin(widget.wallet.project.coinType),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

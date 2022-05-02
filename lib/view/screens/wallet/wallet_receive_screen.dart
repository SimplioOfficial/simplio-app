import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletReceiveScreen extends StatefulWidget {
  final AssetWallet assetWallet;

  const WalletReceiveScreen({Key? key, required this.assetWallet})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletReceiveScreen();
}

class _WalletReceiveScreen extends State<WalletReceiveScreen> {
  @override
  Widget build(BuildContext context) {
    HDWallet? trustWallet =
        (BlocProvider.of<TrustWalletCoreBloc>(context).state as TrustWalletCore)
            .trustWallet;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive'),
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
                  widget.assetWallet.assetId,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  trustWallet!.getAddressForCoin(
                      widget.assetWallet.wallets.first.coinType),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: ElevatedButton(
                key: const Key('new-address-button'),
                child: const Text('New address'),
                onPressed: () {
                  // Navigator.of(context).pushNamed(WalletNavigator.send);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

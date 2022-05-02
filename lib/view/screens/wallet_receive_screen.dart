import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/wallet_core_repository.dart';

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
    var walletCore = context.read<WalletCoreRepository>();

    print('23 ${widget.assetWallet.asset.assetTypes}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new),
        //   onPressed: () => AppRoute.walletNav.currentState?.pop(),
        // ),
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
                  walletCore.getAddress(widget
                      .assetWallet.asset.assetTypes.first.network.coinType),
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

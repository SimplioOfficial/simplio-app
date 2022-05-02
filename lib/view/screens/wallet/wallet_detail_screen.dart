import 'package:crypto_assets/crypto_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/logic/wallet_utils.dart';
import 'package:simplio_app/view/routes/app_route.dart';
import 'package:simplio_app/view/routes/home_wallet_route.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletDetailScreen extends StatefulWidget {
  final AssetWallet assetWallet;

  const WalletDetailScreen({Key? key, required this.assetWallet})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletDetailScreen();
}

class _WalletDetailScreen extends State<WalletDetailScreen> {
  @override
  Widget build(BuildContext context) {
    HDWallet? trustWallet =
        BlocProvider.of<TrustWalletCoreBloc>(context).state.trustWallet;

    BigInt balance = BigInt.zero;
    widget.assetWallet.asset.assetTypes
        .map((assetType) async {
          return await WalletUtils.getBalance(
            network: assetType.network,
            address:
                trustWallet?.getAddressForCoin(assetType.network.coinType) ??
                    '',
            contractAddress:
                assetType is TokenAsset ? assetType.contractAddress : null,
          );
        })
        .toList()
        .forEach((element) async {
          balance = (balance + (await element));
        });

    return FutureBuilder<BigInt>(
      future: Future.value(balance),
      // initialData: BigInt.zero,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.assetWallet.assetId),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => AppRoute.authGuardNav.currentState?.pop(),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'Available amount: ${snapshot.data}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 20.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: ElevatedButton(
                    key: const Key('send_button'),
                    child: const Text('Send'),
                    onPressed: () => AppRoute.walletNav.currentState?.pushNamed(
                      HomeWalletRoute.send,
                      arguments: widget.assetWallet,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    left: 10.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: ElevatedButton(
                    key: const Key('receive_button'),
                    child: const Text('Receive'),
                    onPressed: () => AppRoute.walletNav.currentState?.pushNamed(
                      HomeWalletRoute.receive,
                      arguments: widget.assetWallet,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

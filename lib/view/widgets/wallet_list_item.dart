import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/trust_wallet_repository.dart';
import 'package:simplio_app/logic/wallet_utils.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletListItem extends StatefulWidget {
  final AssetWallet assetWallet;
  final GestureTapCallback onTap;
  final HDWallet trustWallet;

  const WalletListItem(
      {Key? key,
      required this.assetWallet,
      required this.onTap,
      required this.trustWallet})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletListItem();
}

class _WalletListItem extends State<WalletListItem> {
  var totalBalance = BigInt.zero;

  _WalletListItem() {
    // print('26 ${widget.trustWallet ?? 'aaa'}');
    // if (widget.trustWallet != null) {
    //   print(27);
    //   WalletUtils.getAssetBalance(
    //           assetWallet: widget.assetWallet, trustWallet: widget.trustWallet)
    //       .then((value) => setState(() => totalBalance = value));
    // }
  }

  @override
  Widget build(BuildContext context) {
    HDWallet? trustWallet = context.read<TrustWalletRepository>().trustWallet;
    if (trustWallet != null) {
      WalletUtils.getAssetBalance(
              assetWallet: widget.assetWallet, trustWallet: trustWallet)
          .then((value) => () => totalBalance = value);
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    widget.assetWallet.asset.detail.style.primaryColor,
                foregroundColor:
                    widget.assetWallet.asset.detail.style.foregroundColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.assetWallet.asset.detail.name,
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      totalBalance.toString() +
                          " " +
                          widget.assetWallet.asset.detail.ticker,
                      style: const TextStyle(color: Colors.black26),
                    ),
                    // Text(
                    //   widget.assetWallet.asset.detail.ticker.toUpperCase(),
                    //   style: const TextStyle(color: Colors.black26),
                    // ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

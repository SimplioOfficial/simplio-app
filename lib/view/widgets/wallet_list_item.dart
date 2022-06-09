import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';

class WalletListItem extends StatefulWidget {
  final AssetWallet assetWallet;
  final GestureTapCallback onTap;

  const WalletListItem(
      {super.key, required this.assetWallet, required this.onTap});

  @override
  State<StatefulWidget> createState() => _WalletListItem();
}

class _WalletListItem extends State<WalletListItem> {
  @override
  Widget build(BuildContext context) {
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
                      widget.assetWallet.asset.detail.ticker.toUpperCase(),
                      style: const TextStyle(color: Colors.black26),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

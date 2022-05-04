import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet.dart';

class WalletListItem extends StatefulWidget {
  final Wallet wallet;
  final GestureTapCallback onTap;

  const WalletListItem({Key? key, required this.wallet, required this.onTap})
      : super(key: key);

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
                backgroundColor: widget.wallet.asset.style.primaryColor,
                foregroundColor: widget.wallet.asset.style.foregroundColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.wallet.asset.name,
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      widget.wallet.asset.ticker.toUpperCase(),
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

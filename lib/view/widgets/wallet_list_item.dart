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
                backgroundColor: widget.wallet.project.primaryColor,
                child: Icon(widget.wallet.project.icon, size: 18.0),
                foregroundColor: widget.wallet.project.foregroundColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.wallet.project.name,
                      textScaleFactor: 1.2,
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Text(widget.wallet.project.ticker.toUpperCase()),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
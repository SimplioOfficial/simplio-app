import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet.dart';

class WalletListItem extends StatefulWidget {
  final Wallet wallet;

  const WalletListItem({Key? key, required this.wallet}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletListItem();
}

class _WalletListItem extends State<WalletListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(widget.wallet.name),
            )
          ],
        ));
  }
}
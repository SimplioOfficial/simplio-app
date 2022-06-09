import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';

class WalletScreen extends StatefulWidget {
  final AssetWallet assetWallet;

  const WalletScreen({super.key, required this.assetWallet});

  @override
  State<StatefulWidget> createState() => _WalletScreen();
}

class _WalletScreen extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.assetWallet.asset.detail.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }
}

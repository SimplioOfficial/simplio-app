import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet.dart';

class WalletScreen extends StatefulWidget {
  final Wallet wallet;

  const WalletScreen({Key? key, required this.wallet}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletScreen();
}

class _WalletScreen extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wallet.project.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
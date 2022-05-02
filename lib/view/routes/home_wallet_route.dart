import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/screens/wallet_detail_screen.dart';
import 'package:simplio_app/view/screens/wallet_receive_screen.dart';
import 'package:simplio_app/view/screens/wallet_send_screen.dart';

class HomeWalletRoute {
  static const String initial = '/';
  static const String detail = '/detail';
  static const String receive = '/receive';
  static const String send = '/send';

  final AssetWallet assetWallet;

  const HomeWalletRoute({required this.assetWallet});

  Route<dynamic> generateRoute(RouteSettings settings) {
    print('16 ${settings.name}');
    switch (settings.name) {
      case initial:
      case detail:
        return MaterialPageRoute(
          builder: (context) => WalletDetailScreen(assetWallet: assetWallet),
        );
      case send:
        return MaterialPageRoute(
          builder: (context) => WalletSendScreen(assetWallet: assetWallet),
        );
      case receive:
        return MaterialPageRoute(
          builder: (context) => WalletReceiveScreen(assetWallet: assetWallet),
        );
      default:
        throw const FormatException('Screen not found');
    }
  }
}

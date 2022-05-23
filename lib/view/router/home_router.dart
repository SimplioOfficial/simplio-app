import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

class HomeRouter {
  // Defining names.
  static const String assets = '/assets';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      case assets:
        return MaterialPageRoute(
          builder: (_) => const AssetsScreen(),
        );
      case wallet:
        return MaterialPageRoute(
            builder: (_) => WalletScreen(
                  assetWallet: settings.arguments! as AssetWallet,
                ));
      case '/':
        return MaterialPageRoute(
          builder: (_) => Container(),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

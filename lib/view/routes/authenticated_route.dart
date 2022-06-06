import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

class AuthenticatedRoute {
  static final key = GlobalKey<NavigatorState>(
    debugLabel: 'authenticated_route',
  );

  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case wallet:
        return MaterialPageRoute(
            builder: (_) => WalletScreen(
                  assetWallet: settings.arguments! as AssetWallet,
                ));
      case assets:
        return MaterialPageRoute(
          builder: (_) => const AssetsScreen(),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

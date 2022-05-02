import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/routes/home_initial_route.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

class HomeRoute {
  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';
  static const String initialSettings = '/initial-settings';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
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
      case initialSettings:
        return MaterialPageRoute(
          builder: (_) => Navigator(
            onGenerateRoute: HomeInitialRoute().generateRoute,
            initialRoute: '/',
          ),
        );
      default:
        throw const FormatException('Screen not found');
    }
  }
}

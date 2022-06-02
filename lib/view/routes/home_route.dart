import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/routes/_route_utils.dart';
import 'package:simplio_app/view/routes/app_route.dart';
import 'package:simplio_app/view/routes/home_initial_route.dart';
import 'package:simplio_app/view/routes/home_wallet_route.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';

class HomeRoute {
  static const String dashboard = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';
  static const String initialSettings = '/initial-settings';

  Route<dynamic> generateRoute(RouteSettings settings) {
    print('45 ${settings.name}  ${settings.arguments}');
    switch (settings.name) {
      // switch (RouteUtils.getSubroute(settings, '/home')) {
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case wallet:
        return MaterialPageRoute(
          builder: (_) => Navigator(
            key: AppRoute.walletNav,
            onGenerateRoute: (_) =>
                HomeWalletRoute(assetWallet: settings.arguments as AssetWallet)
                    .generateRoute(settings: _),
          ),
        );
      case assets:
        return MaterialPageRoute(
          builder: (_) => const AssetsScreen(),
        );
      case initialSettings:
        return MaterialPageRoute(
          builder: (_) => Navigator(
            onGenerateRoute: (_) => HomeInitialRoute().generateRoute(_),
          ),
        );
      default:
        throw const FormatException('Screen not found');
    }
  }
}

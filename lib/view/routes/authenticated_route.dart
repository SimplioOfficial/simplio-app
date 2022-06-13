import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/routes/settings/authenticated_settings.dart';
import 'package:simplio_app/view/screens/configuration_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/inventory_screen.dart';
import 'package:simplio_app/view/screens/portfolio_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

class AuthenticatedRoute {
  static final key = GlobalKey<NavigatorState>(
    debugLabel: 'authenticated_route',
  );

  static const String home = '/';
  static const String portfolio = '/portfolio';
  static const String inventory = '/inventory';
  static const String configuration = '/configuration';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageRouteBuilder(
          settings: AuthenticatedSettings(
            tapBar: TapBarRouteSettings(
              selectedKey: TabBarItemKeys.dashboard,
            ),
          ),
          pageBuilder: (_, __, ___) => const DashboardScreen(),
        );
      case portfolio:
        return PageRouteBuilder(
          settings: AuthenticatedSettings(
            tapBar: TapBarRouteSettings(
              selectedKey: TabBarItemKeys.portfolio,
            ),
          ),
          pageBuilder: (_, __, ___) => const PortfolioScreen(),
        );
      case inventory:
        return PageRouteBuilder(
          settings: AuthenticatedSettings(
            tapBar: TapBarRouteSettings(
              selectedKey: TabBarItemKeys.inventory,
            ),
          ),
          pageBuilder: (_, __, ___) => const InventoryScreen(),
        );
      case configuration:
        return PageRouteBuilder(
          settings: AuthenticatedSettings(
            tapBar: TapBarRouteSettings(
              selectedKey: TabBarItemKeys.configuration,
            ),
          ),
          pageBuilder: (_, __, ___) => const ConfigurationScreen(),
        );
      case wallet:
        return MaterialPageRoute(
          builder: (_) => WalletScreen(
            assetWallet: settings.arguments! as AssetWallet,
          ),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

class TabBarItemKeys {
  static const Key dashboard = ValueKey('dashboard');
  static const Key portfolio = ValueKey('portfolio');
  static const Key inventory = ValueKey('inventory');
  static const Key configuration = ValueKey('configuration');

  const TabBarItemKeys._();
}

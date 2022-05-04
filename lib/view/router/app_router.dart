import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

class AppRouter {
  // Defining names.
  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case assets:
        return MaterialPageRoute(
          builder: (_) => const AssetsScreen(),
        );
      case wallet:
        return MaterialPageRoute(
            builder: (_) => WalletScreen(
                  wallet: settings.arguments! as Wallet,
                ));

      default:
        throw const FormatException('Screen not found');
    }
  }
}

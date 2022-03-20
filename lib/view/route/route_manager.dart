import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/data/model/wallet_project.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';
import 'package:simplio_app/view/screens/wallet_projects_screen.dart';

class RouteManager {
  static const String home = '/';
  static const String walletProjects = '/wallet-projects';
  static const String wallet = '/wallet';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(
            key: Key(home),
          ),
        );
      case walletProjects:
        return MaterialPageRoute(
            builder: (context) => WalletProjectsScreen(
                  key: const Key(walletProjects),
                  supportedProjects: settings.arguments as List<WalletProject>,
                ));
      case wallet:
        return MaterialPageRoute(
            builder: (context) => WalletScreen(
                  key: const Key(wallet),
                  wallet: settings.arguments! as Wallet,
                ));

      default:
        throw const FormatException('Screen not found');
    }
  }
}
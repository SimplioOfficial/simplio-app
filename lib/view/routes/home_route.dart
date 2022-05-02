import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/routes/_route_utils.dart';
import 'package:simplio_app/view/routes/home_initial_route.dart';
import 'package:simplio_app/view/routes/home_wallet_route.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';

class HomeRoute {
  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';
  static const String initialSettings = '/initial-settings';

  Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name! == home) {
      return MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      );
    } else if (settings.name!.startsWith(wallet)) {
      return MaterialPageRoute(
        builder: (_) => Navigator(
          onGenerateRoute: (_) => HomeWalletRoute().generateRoute(
              assetWallet: settings.arguments as AssetWallet, settings: _),
        ),
      );
    } else if (settings.name!.startsWith(assets)) {
      return MaterialPageRoute(
        builder: (_) => const AssetsScreen(),
      );
    } else if (settings.name!.startsWith(initialSettings)) {
      return MaterialPageRoute(
        builder: (_) => Navigator(
          onGenerateRoute: HomeInitialRoute().generateRoute,
        ),
      );
    } else {
      throw const FormatException('Screen not found');
    }

    // switch (settings.name) {
    //   case home:
    //     return MaterialPageRoute(
    //       builder: (_) => const DashboardScreen(),
    //     );
    //   case wallet:
    //     return MaterialPageRoute(
    //       builder: (_) => Navigator(
    //         onGenerateRoute: (_) => HomeWalletRoute().generateRoute(settings),
    //         // settings: settings,
    //         // baseRoute: wallet,m
    //       ),
    //     );
    //   case assets:
    //     return MaterialPageRoute(
    //       builder: (_) => const AssetsScreen(),
    //     );
    //   case initialSettings:
    //     return MaterialPageRoute(
    //       builder: (_) => Navigator(
    //           onGenerateRoute: RouteUtils.onGenerateSubRoute(
    //         onGenerateRoute: HomeInitialRoute().generateRoute,
    //         settings: settings,
    //         baseRoute: initialSettings,
    //         subRoute: settings.name ?? '',
    //       )),
    //     );
    //   default:
    //     throw const FormatException('Screen not found');
    // }
  }
}

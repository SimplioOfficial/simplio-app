import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/logic/asset_wallet_bloc/asset_wallet_bloc.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

class HomeRoute {
  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
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
      case home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AssetWalletBloc(),
            child: const DashboardScreen(),
          ),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/logic/asset_wallet_bloc/asset_wallet_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/login_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';

import 'auth_guard.dart';

class AppRouter {
  // Defining names.
  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => AuthGuard(
            redirectedWidget: BlocProvider(
              create: (context) => LoginBloc(
                  accountRepository:
                      RepositoryProvider.of<AccountRepository>(context)),
              child: const LoginScreen(),
            ),
            guardedWidget: BlocProvider(
              create: (context) => AssetWalletBloc(),
              child: const DashboardScreen(),
            ),
          ),
        );
      case assets:
        return MaterialPageRoute(
          builder: (_) => const AssetsScreen(),
        );
      case wallet:
        return MaterialPageRoute(
            builder: (_) => WalletScreen(
                  assetWallet: settings.arguments! as AssetWallet,
                ));

      default:
        throw const FormatException('Screen not found');
    }
  }
}

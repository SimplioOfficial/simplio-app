import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/config/projects.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';
import 'package:simplio_app/view/screens/wallet_projects_screen.dart';

class AppRouter {
  final WalletBloc _walletBloc = WalletBloc();

  // Defining names.
  static const String home = '/';
  static const String walletProjects = '/wallet-projects';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _walletBloc,
            child: const DashboardScreen(),
          ),
        );
      case walletProjects:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _walletBloc,
                  child: const WalletProjectsScreen(
                    projects: Projects.supported,
                  ),
                ));
      case wallet:
        return MaterialPageRoute(
            builder: (context) => WalletScreen(
                  wallet: settings.arguments! as Wallet,
                ));

      default:
        throw const FormatException('Screen not found');
    }
  }

  void dispose() {
    _walletBloc.close();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/config/projects.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/bloc_providers.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/wallet_screen.dart';
import 'package:simplio_app/view/screens/wallet_projects_screen.dart';
import 'package:simplio_app/view/screens/generate_seed_screen.dart';

class AppRouter {
  // Defining names.
  static const String home = '/';
  static const String generateSeed = '/generate-seed';
  static const String walletProjects = '/wallet-projects';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProviders.trustWalletCoreBloc),
              BlocProvider.value(value: BlocProviders.walletBloc),
            ],
            child: const DashboardScreen(),
          ),
        );
      case generateSeed:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProviders.trustWalletCoreBloc,
            child: const GenerateSeedScreen(),
          ),
        );
      case walletProjects:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProviders.walletBloc,
            child: const WalletProjectsScreen(
              projects: Projects.supported,
            ),
          ),
        );
      case wallet:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProviders.trustWalletCoreBloc,
            child: WalletScreen(
              wallet: settings.arguments! as Wallet,
            ),
          ),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }

  void dispose() {
    BlocProviders.walletBloc.close();
    BlocProviders.trustWalletCoreBloc.close();
  }
}

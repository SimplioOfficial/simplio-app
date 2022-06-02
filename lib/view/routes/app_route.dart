import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/data/repositories/trust_wallet_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/asset_wallet_bloc/asset_wallet_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/view/guards/auth_guard.dart';
import 'package:simplio_app/view/routes/_route_utils.dart';
import 'package:simplio_app/view/routes/home_route.dart';
import 'package:simplio_app/view/screens/login_screen.dart';

class AppRoute {
  static const String home = '/';
  static const String login = '/login';

  static GlobalKey<NavigatorState> mainAppNav =
      GlobalKey(debugLabel: 'mainAppNav');
  static GlobalKey<NavigatorState> authGuardNav =
      GlobalKey(debugLabel: 'authGuardNav');
  static GlobalKey<NavigatorState> walletNav =
      GlobalKey(debugLabel: 'walletNav');

  Route<dynamic> generateRoute(RouteSettings settings) {
    print('*****************************');
    print(
        '21 ${settings.name} ${RouteUtils.getParentRoute(settings.name ?? '')}');
    switch (RouteUtils.getParentRoute(settings.name ?? '')) {
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
            ),
            child: const LoginScreen(),
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AssetWalletBloc(
                  assetWalletRepository:
                      RepositoryProvider.of<AssetWalletRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => TrustWalletCoreBloc(
                  trustWalletRepository:
                      RepositoryProvider.of<TrustWalletRepository>(context),
                ),
              ),
            ],
            child: AuthGuard(
              navigatorKey: authGuardNav,
              initialRoute: HomeRoute.dashboard,
              onGenerateRoute: HomeRoute().generateRoute,
              onAccountChange: (context, state) {
                if (state.status == AccountStatus.unauthenticated) {
                  Navigator.of(context).popAndPushNamed(login);
                }
              },
            ),
          ),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

class RouteName {
  static const base = {
    'home': AppRoute.home,
    'login': AppRoute.login,
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/view/guards/auth_guard.dart';
import 'package:simplio_app/view/routes/home_route.dart';
import 'package:simplio_app/view/screens/login_screen.dart';

class AppRoute {
  static const String home = '/';
  static const String login = '/login';
  static const String assets = '/assets';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
          builder: (_) => AuthGuard(
            initialRoute: HomeRoute.home,
            onGenerateRoute: HomeRoute().generateRoute,
            onAccountChange: (context, state) {
              if (state.status == AccountStatus.unauthenticated) {
                Navigator.of(context).popAndPushNamed(login);
              }
            },
          ),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

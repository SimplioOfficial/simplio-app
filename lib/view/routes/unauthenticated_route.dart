import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/view/screens/login_screen.dart';
import 'package:simplio_app/view/screens/welcome_screen.dart';

class UnauthenticatedRoute {
  static final key = GlobalKey<NavigatorState>(
    debugLabel: 'unauthenticated_route',
  );

  static const String home = '/';
  static const String login = '/login';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            child: const LoginScreen(),
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

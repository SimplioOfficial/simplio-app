import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/screens/onboarding_screen.dart';
import 'package:simplio_app/view/screens/sign_in_screen.dart';
import 'package:simplio_app/view/screens/password_reset_screen.dart';
import 'package:simplio_app/view/screens/sign_up_screen.dart';
import 'package:simplio_app/view/screens/welcome_screen.dart';

class UnauthenticatedRoute {
  static final key = GlobalKey<NavigatorState>(
    debugLabel: 'unauthenticated_route',
  );

  static const String home = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String passwordReset = '/passwordReset';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case signIn:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthFormCubit.builder(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            child: const SignInScreen(),
          ),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthFormCubit.builder(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            child: const SignUpScreen(),
          ),
        );
      case passwordReset:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthFormCubit.builder(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            child: const PasswordResetScreen(),
          ),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

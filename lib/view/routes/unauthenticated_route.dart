import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/security_form_cubit/security_form_cubit.dart';
import 'package:simplio_app/view/screens/onboarding_screen.dart';
import 'package:simplio_app/view/screens/pin_setup_screen.dart';
import 'package:simplio_app/view/screens/sign_in_screen.dart';
import 'package:simplio_app/view/screens/password_reset_screen.dart';
import 'package:simplio_app/view/screens/sign_up_screen.dart';

class UnauthenticatedRoute {
  static final key = GlobalKey<NavigatorState>(
    debugLabel: 'unauthenticated_route',
  );

  static const String home = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String setupPin = '/setup-pin';
  static const String passwordReset = '/passwordReset';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case signIn:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case setupPin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SecurityFormCubit.builder(),
            child: const PinSetupScreen(),
          ),
        );
      case passwordReset:
        return MaterialPageRoute(
          builder: (context) => const PasswordResetScreen(),
        );

      default:
        throw const FormatException('Screen not found');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';

class AuthGuard extends StatelessWidget {
  final Widget Function(BuildContext context, Authenticated state)
      onAuthenticated;
  final Widget Function(BuildContext context) onUnauthenticated;

  const AuthGuard({
    super.key,
    required this.onAuthenticated,
    required this.onUnauthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => state is Authenticated
          ? onAuthenticated(context, state)
          : onUnauthenticated(context),
    );
  }
}

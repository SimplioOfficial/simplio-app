import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';

class AuthGuard extends StatelessWidget {
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final Function(BuildContext, AccountState) onAccountChange;
  final GlobalKey<NavigatorState> navigatorKey;

  const AuthGuard({
    Key? key,
    required this.initialRoute,
    required this.onGenerateRoute,
    required this.onAccountChange,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        onAccountChange(context, state);
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

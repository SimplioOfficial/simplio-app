import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';

class AuthGuard extends StatefulWidget {
  final Widget guardedWidget;
  final Widget redirectedWidget;
  final Widget waitingWidget;

  const AuthGuard({
    Key? key,
    required this.guardedWidget,
    required this.redirectedWidget,
    this.waitingWidget = const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator())),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthGuard();
}

class _AuthGuard extends State<AuthGuard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      buildWhen: (previous, current) {
        if (previous is Accounts && current is Accounts) {
          return previous.status != current.status;
        }
        return false;
      },
      builder: (context, state) {
        if (state is! Accounts) return widget.waitingWidget;

        switch (state.status) {
          case AccountStatus.authenticated:
            return widget.guardedWidget;
          default:
            return widget.redirectedWidget;
        }
      },
    );
  }
}

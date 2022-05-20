import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/view/screens/login_screen.dart';

class AuthGuard extends StatefulWidget {
  final Widget guardedWidget;
  final Widget redirectedWidget;
  final Widget waitingWidget;

  const AuthGuard({
    Key? key,
    required this.guardedWidget,
    this.redirectedWidget = const LoginScreen(),
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
    return FutureBuilder<AccountStatus>(
      future: Future.delayed(
        const Duration(seconds: 1),
        () => (BlocProvider.of<AccountBloc>(context).state as Accounts).status,
      ),
      builder: (BuildContext context, AsyncSnapshot<AccountStatus> snapshot) {
        if (!snapshot.hasData) return widget.waitingWidget;

        if (snapshot.data == AccountStatus.unauthenticated) {
          return BlocProvider(
            create: (context) => LoginBloc(
                accountRepository:
                    RepositoryProvider.of<AccountRepository>(context)),
            child: widget.redirectedWidget,
          );
        }

        return widget.guardedWidget;
      },
    );
  }
}

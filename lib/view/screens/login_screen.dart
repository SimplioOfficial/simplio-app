import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final res = state.response;

        if (res is LoginSuccess) {
          context
              .read<AuthBloc>()
              .add(GotAuthenticated(accountId: res.account.id));
        }

        if (res is LoginFailure) {
          //  TODO: Implement logic for failure.
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          foregroundColor: Colors.black87,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextHeader(
                        title: context.locale.loginScreenTitle,
                        subtitle: context.locale.loginScreenSubTitle,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: LoginFormFields(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(const LoginRequested());
                    },
                    child: Text(context.locale.loginBtn),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({super.key});

  @override
  State<StatefulWidget> createState() => _LoginForm();
}

class _LoginForm extends State<LoginFormFields> {
  bool _passwordDisplayed = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            validator: (email) => null,
            decoration: InputDecoration(
              labelText: context.locale.usernameInputLabel,
            ),
            onChanged: (String? email) => context
                .read<LoginBloc>()
                .add(LoginFormChanged(username: email)),
          ),
          TextField(
            obscureText: _passwordDisplayed,
            onChanged: (String? password) => context
                .read<LoginBloc>()
                .add(LoginFormChanged(password: password)),
            decoration: InputDecoration(
                labelText: context.locale.passwordInputLabel,
                suffixIcon: IconButton(
                    icon: Icon(_passwordDisplayed
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordDisplayed = !_passwordDisplayed;
                      });
                    })),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print("LISTENING ${state.runtimeType}");
        if (state is LoginSuccess) {
          context
              .read<AccountBloc>()
              .add(AccountChanged(account: state.account));
        }

        if (state is LoginFailure) {
          print('LOGIN HAS FAILED');
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 60.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: LoginFormFields(),
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (_, state) =>
                  state is LoginForm ? Text(state.email) : Container(),
            ),
            BlocBuilder<AccountBloc, AccountState>(
              builder: (_, state) {
                print("BUILDER ${state.props}");
                return state is Accounts && state.account != null
                    ? Text(state.account!.id)
                    : Container();
              },
            ),
            ElevatedButton(
              onPressed: () =>
                  context.read<LoginBloc>().add(const LoginRequested()),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({Key? key}) : super(key: key);

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
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: (email) => null,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            onChanged: (String? email) =>
                context.read<LoginBloc>().add(LoginFormChanged(id: email)),
          ),
          TextField(
            obscureText: _passwordDisplayed,
            onChanged: (String? password) => context
                .read<LoginBloc>()
                .add(LoginFormChanged(password: password)),
            decoration: InputDecoration(
                labelText: 'Password',
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

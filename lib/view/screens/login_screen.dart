import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/login_bloc/login_bloc.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.response.runtimeType) {
          case LoginSuccess:
            final res = state.response as LoginSuccess;
            context
                .read<AccountBloc>()
                .add(AccountChanged(account: res.account));
            break;
          case LoginFailure:
            print('LOGIN HAS FAILED');
            break;
          default:
            print("STATE HAS NOT RESPONSE");
            break;
        }
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 60.0,
                        right: 20.0,
                        bottom: 20.0,
                        left: 20.0,
                      ),
                      child: TextHeader(
                          title: "Enter Simplio.",
                          subtitle: "It's good to see you back."),
                    ),
                    Padding(
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
                    onPressed: () =>
                        context.read<LoginBloc>().add(const LoginRequested()),
                    child: const Text('Login'),
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

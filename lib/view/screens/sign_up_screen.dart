import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/widgets/password_text_field.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthFormCubit, AuthFormState>(
      listener: (context, state) {
        final res = state.response;

        if (res is SignInFormSuccess) {
          context
              .read<AuthBloc>()
              .add(GotAuthenticated(accountId: res.account.id));
        }

        if (res is SignInFormFailure) {
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextHeader(
                        title: "Create an account",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              autofocus: true,
                              validator: (email) => null,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                              onChanged: (String? email) {
                                context
                                    .read<AuthFormCubit>()
                                    .changeSignUpForm(login: email);
                              },
                            ),
                            PasswordTextField(
                              onChanged: (password) {
                                context
                                    .read<AuthFormCubit>()
                                    .changeSignUpForm(password: password);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<AuthFormCubit>().requestSignUp();
                        },
                        child: const Text('Create account'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/widgets/password_text_field.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                        title: "Enter Simplio",
                        subtitle: "It's good to see you back.",
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
                                    .changeSignInForm(login: email);
                              },
                            ),
                            PasswordTextField(
                              onChanged: (password) {
                                context
                                    .read<AuthFormCubit>()
                                    .changeSignInForm(password: password);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          final res =
                              context.read<AuthFormCubit>().state.response;
                          if (res is! SignInFormPending) {
                            Navigator.of(context)
                                .pushNamed(UnauthenticatedRoute.passwordReset);
                          }
                        },
                        child: Text("Forgot password?",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
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
                      child: BlocBuilder<AuthFormCubit, AuthFormState>(
                        builder: (context, state) {
                          if (state.response != null) {
                            final res = state.response;
                            if (res is SignInFormPending) {
                              return OutlinedButton(
                                onPressed: () {},
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text('Signing in...'),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<AuthFormCubit>()
                                  .requestSignIn();
                            },
                            child: const Text('Sign in'),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: Text('or Create account',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                        onTap: () {
                          final res =
                              context.read<AuthFormCubit>().state.response;
                          if (res is! SignInFormPending) {
                            Navigator.of(context)
                                .pushNamed(UnauthenticatedRoute.signUp);
                          }
                        },
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

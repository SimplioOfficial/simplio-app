import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/themes/common_theme.dart';
import 'package:simplio_app/view/widgets/password_text_field.dart';
import 'package:simplio_app/view/widgets/text_header.dart';
import 'package:simplio_app/view/widgets/themed_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(elevation: 0.0),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: CommonTheme.horizontalPadding,
                    child: TextHeader(
                      title: context.locale.loginScreenTitle,
                      subtitle: context.locale.loginScreenSubTitle,
                    ),
                  ),
                  Padding(
                    padding: CommonTheme.horizontalPadding,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: CommonTheme.verticalPadding,
                            child: ThemedTextFormFiled(
                              keyboardType: TextInputType.emailAddress,
                              // autofocus: true,
                              validator: (email) => context
                                  .read<AuthFormCubit>()
                                  .state
                                  .signInForm
                                  .login
                                  .emailValidator(email, context),
                              decoration: InputDecoration(
                                labelText: context.locale.email,
                                hintText: context.locale.email,
                              ),
                              onChanged: (String? email) {
                                context
                                    .read<AuthFormCubit>()
                                    .changeSignInForm(login: email);
                              },
                              onFocusChange: (focused) => focused
                                  ? null
                                  : formKey.currentState?.validate(),
                            ),
                          ),
                          PasswordTextField(
                            validator: (pass) => context
                                .read<AuthFormCubit>()
                                .state
                                .signInForm
                                .password
                                .passwordValidator(pass, context),
                            passwordComplexityCondition: (_) => context
                                .read<AuthFormCubit>()
                                .state
                                .signInForm
                                .password
                                .isValid,
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
                    padding:
                        const EdgeInsets.only(top: 10, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        final res =
                            context.read<AuthFormCubit>().state.response;
                        if (res is! SignInFormPending) {
                          Navigator.of(context)
                              .pushNamed(UnauthenticatedRoute.passwordReset);
                        }
                      },
                      child: Text(
                        context.locale.forgotPasswordButtonLabel,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: CommonTheme.horizontalPadding,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: CommonTheme.paddingAll,
                                          child: Text(
                                            context.locale.signingInLabel,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }
                              return ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await context
                                        .read<AuthFormCubit>()
                                        .requestSignIn();
                                  }
                                },
                                child: Text(context.locale.signInButtonLabel),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            child: Text(
                              context.locale.orCreateAccountButtonLabel,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}

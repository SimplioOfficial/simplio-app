import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/themes/common_theme.dart';
import 'package:simplio_app/view/widgets/password_rules_row.dart';
import 'package:simplio_app/view/widgets/password_text_field.dart';
import 'package:simplio_app/view/widgets/text_header.dart';
import 'package:simplio_app/view/widgets/themed_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
        appBar: AppBar(
          key: const Key('sign-up-screen-app-bar-button'),
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: CommonTheme.paddingAll,
                    child: TextHeader(
                      title: context.locale.createNewAccountTitle,
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
                              key: const Key('sign-up-screen-email-text-field'),
                              autofocus: true,
                              validator: (email) => context
                                  .read<AuthFormCubit>()
                                  .state
                                  .signUpForm
                                  .login
                                  .emailValidator(email, context),
                              decoration: InputDecoration(
                                labelText: context.locale.email,
                                hintText: context.locale.email,
                              ),
                              onChanged: (String? email) {
                                context
                                    .read<AuthFormCubit>()
                                    .changeSignUpForm(login: email);
                              },
                              onFocusChange: (focused) => focused
                                  ? null
                                  : formKey.currentState?.validate(),
                            ),
                          ),
                          PasswordTextField(
                            key:
                                const Key('sign-up-screen-password-text-field'),
                            passwordComplexityCondition: (pass) => context
                                .read<AuthFormCubit>()
                                .state
                                .signUpForm
                                .password
                                .isValid,
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
                  Padding(
                    padding: CommonTheme.paddingAll,
                    child: BlocBuilder<AuthFormCubit, AuthFormState>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) => Column(
                        children: [
                          PasswordRulesRow(
                              key: const Key(
                                  'sign-up-screen-length-password-rule'),
                              text: context.locale.passwordRuleAtLeast8Chars,
                              passed: state.signUpForm.password
                                      .missingValue['length'] ??
                                  false),
                          PasswordRulesRow(
                              key: const Key(
                                  'sign-up-screen-number-password-rule'),
                              text: context.locale.passwordRuleNumChar,
                              passed: state.signUpForm.password
                                      .missingValue['numberChar'] ??
                                  false),
                          PasswordRulesRow(
                              key: const Key(
                                  'sign-up-screen-special-char-password-rule'),
                              text: context.locale.passwordRuleSpecialChar,
                              passed: state.signUpForm.password
                                      .missingValue['specialChar'] ??
                                  false),
                          PasswordRulesRow(
                              key: const Key(
                                  'sign-up-screen-upper-char-password-rule'),
                              text: context.locale.passwordRuleUpperChar,
                              passed: state.signUpForm.password
                                      .missingValue['upperChar'] ??
                                  false),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: CommonTheme.paddingAll,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: const Key('sign-up-screen-sign-in-button'),
                            onPressed: () async {
                              if (context
                                  .read<AuthFormCubit>()
                                  .state
                                  .signUpForm
                                  .isValid) {
                                await context
                                    .read<AuthFormCubit>()
                                    .requestSignUp();
                              } else {
                                formKey.currentState!.validate();
                              }
                            },
                            child: Text(context.locale.createAccountBtnLabel),
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

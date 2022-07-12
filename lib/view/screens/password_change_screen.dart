import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/themes/common_theme.dart';
import 'package:simplio_app/view/widgets/password_rules_row.dart';
import 'package:simplio_app/view/widgets/password_text_field.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocListener<AuthFormCubit, AuthFormState>(
      listener: (context, state) {
        // TODO: handle responses
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.locale.changePasswordPageTitle),
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: CommonTheme.horizontalPadding,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            PasswordTextField(
                              key: UniqueKey(),
                              labelText: context.locale.oldPasswordInputLabel,
                              validator: (pass) => context
                                  .read<AuthFormCubit>()
                                  .state
                                  .passwordChangeForm
                                  .newPassword
                                  .passwordValidator(pass, context),
                              passwordComplexityCondition: (pass) => context
                                  .read<AuthFormCubit>()
                                  .state
                                  .passwordChangeForm
                                  .oldPassword
                                  .isValid,
                              onChanged: (password) {
                                context
                                    .read<AuthFormCubit>()
                                    .changePasswordChangeForm(
                                      oldPassword: password,
                                    );
                              },
                            ),
                            Padding(
                              padding: CommonTheme.verticalPadding,
                              child: PasswordTextField(
                                key: UniqueKey(),
                                labelText: context.locale.newPasswordInputLabel,
                                passwordComplexityCondition: (pass) => context
                                    .read<AuthFormCubit>()
                                    .state
                                    .passwordChangeForm
                                    .newPassword
                                    .isValid,
                                onChanged: (password) {
                                  context
                                      .read<AuthFormCubit>()
                                      .changePasswordChangeForm(
                                        newPassword: password,
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: CommonTheme.horizontalPadding,
                      child: BlocBuilder<AuthFormCubit, AuthFormState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) => Column(
                          children: [
                            PasswordRulesRow(
                                text: context.locale.passwordRuleAtLeast8Chars,
                                passed: state.passwordChangeForm.newPassword
                                        .missingValue['length'] ??
                                    false),
                            PasswordRulesRow(
                                text: context.locale.passwordRuleNumChar,
                                passed: state.passwordChangeForm.newPassword
                                        .missingValue['numberChar'] ??
                                    false),
                            PasswordRulesRow(
                                text: context.locale.passwordRuleSpecialChar,
                                passed: state.passwordChangeForm.newPassword
                                        .missingValue['specialChar'] ??
                                    false),
                            PasswordRulesRow(
                                text: context.locale.passwordRuleUpperChar,
                                passed: state.passwordChangeForm.newPassword
                                        .missingValue['upperChar'] ??
                                    false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context
                            .read<AuthFormCubit>()
                            .requestPasswordChange();
                      }
                    },
                    child: Text(context.locale.submitBtnLabel),
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

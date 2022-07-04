import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/widgets/text_header.dart';
import 'package:simplio_app/view/widgets/themed_text_form_field.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const TextHeader(
                      title: 'Forgot password',
                    ),
                    Form(
                      key: formKey,
                      child: ThemedTextFormFiled(
                        autofocus: true,
                        validator: (email) => context
                            .read<AuthFormCubit>()
                            .state
                            .passwordResetForm
                            .email
                            .emailValidator(email, context),
                        decoration: InputDecoration(
                          labelText: context.locale.email,
                          hintText: context.locale.email,
                        ),
                        onChanged: (String? email) {
                          context
                              .read<AuthFormCubit>()
                              .changePasswordResetForm(email: email);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthFormCubit>().requestPasswordReset();
                    }
                  },
                  child: Text(context.locale.submitBtnLabel),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

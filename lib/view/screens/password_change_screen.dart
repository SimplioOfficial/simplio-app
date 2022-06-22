import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/widgets/password_text_field.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthFormCubit, AuthFormState>(
      listener: (context, state) {
        // TODO: handle responses
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change password'),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            PasswordTextField(
                              key: UniqueKey(),
                              labelText: 'Old password',
                              onChanged: (password) {
                                context
                                    .read<AuthFormCubit>()
                                    .changePasswordChangeForm(
                                      oldPassword: password,
                                    );
                              },
                            ),
                            PasswordTextField(
                              key: UniqueKey(),
                              labelText: 'New password',
                              onChanged: (password) {
                                context
                                    .read<AuthFormCubit>()
                                    .changePasswordChangeForm(
                                      newPassword: password,
                                    );
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
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<AuthFormCubit>()
                          .requestPasswordChange();
                    },
                    child: const Text('Submit'),
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

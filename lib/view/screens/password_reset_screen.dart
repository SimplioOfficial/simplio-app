import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: TextFormField(
                        autofocus: true,
                        validator: (email) => null,
                        decoration: const InputDecoration(
                          labelText: 'Email',
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
                    context.read<AuthFormCubit>().requestPasswordReset();
                  },
                  child: const Text('Send'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

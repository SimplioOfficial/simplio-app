import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';

part 'auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {
  final AuthRepository _authRepository;

  AuthFormCubit._(
    this._authRepository,
  ) : super(const AuthFormState.init());

  AuthFormCubit.builder({
    required AuthRepository authRepository,
  }) : this._(authRepository);

  void changeSignInForm({
    String? login,
    String? password,
  }) {
    emit(state.copyWith(
      signInForm: state.signInForm.copyWith(
        login: login,
        password: password,
      ),
    ));
  }

  void changeSignUpForm({
    String? login,
    String? password,
  }) {
    emit(state.copyWith(
      signUpForm: state.signUpForm.copyWith(
        login: login,
        password: password,
      ),
    ));
  }

  void changePasswordResetForm({String? email}) {
    emit(state.copyWith(
      passwordResetForm: state.passwordResetForm.copyWith(email: email),
    ));
  }

  void changePasswordChangeForm({
    String? oldPassword,
    String? newPassword,
  }) {
    emit(state.copyWith(
      passwordChangeForm: state.passwordChangeForm.copyWith(
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),
    ));
  }

  Future<void> requestSignIn() async {
    // print("Requesting Sign In - "
    //     "login: ${state.signInForm.login}, "
    //     "password: ${state.signInForm.password}");

    emit(state.copyWith(
      response: const SignInFormPending(),
    ));

    try {
      final login = state.signInForm.login.toString();
      final password = state.signInForm.password.toString();
      final account = await _authRepository.signIn(login, password);

      emit(state.copyWith(
        response: SignInFormSuccess(account: account),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        response: SignInFormFailure(exception: e),
      ));
    }
  }

  Future<void> requestSignUp() async {
    // print("Requesting Sign up - "
    //     "login: ${state.signUpForm.login}, "
    //     "password: ${state.signUpForm.password}");
  }

  Future<void> requestPasswordReset() async {
    // print("Requesting password reset");
  }

  Future<void> requestPasswordChange() async {
    // print("Requesting Password change - "
    //     "old password: ${state.passwordChangeForm.oldPassword}, "
    //     "new password: ${state.passwordChangeForm.newPassword}");
  }
}

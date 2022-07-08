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
    emit(state.copyWith(
      response: const SignUpFormPending(),
    ));

    try {
      await _authRepository.signUp(
        state.signUpForm.login.toString(),
        state.signUpForm.password.toString(),
      );

      emit(state.copyWith(
        response: const SignUpFormSuccess(),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        response: SignUpFormFailure(exception: e),
      ));
    }
  }

  Future<void> requestPasswordReset() async {
    emit(state.copyWith(
      response: const PasswordResetFormPending(),
    ));

    try {
      final email = state.passwordResetForm.email;

      await _authRepository.resetPassword(
        email.toString(),
      );

      emit(state.copyWith(
        response: const PasswordResetFormSuccess(),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        response: PasswordResetFormFailure(exception: e),
      ));
    }
  }

  Future<void> requestPasswordChange() async {
    emit(state.copyWith(
      response: const PasswordChangeFormPending(),
    ));

    try {
      final oldPassword = state.passwordChangeForm.oldPassword;
      final newPassword = state.passwordChangeForm.newPassword;

      await _authRepository.changePassword(
        oldPassword.toString(),
        newPassword.toString(),
      );

      emit(state.copyWith(
        response: const PasswordChangeFormSuccess(),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        response: PasswordChangeFormFailure(exception: e),
      ));
    }
  }
}

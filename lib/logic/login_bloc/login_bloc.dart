import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository accountRepository;

  LoginBloc({required this.accountRepository})
      : super(const LoginForm.empty()) {
    on<LoginRequested>(_onLoginRequested);
    on<LoginFormChanged>(_onLoginFormChanged);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final state = this.state;
      if (state is LoginForm) {
        final Account account = await accountRepository.login(
          state.email,
          state.password,
        );

        emit(LoginSuccess(account));
      }
    } on Exception catch (err, _) {
      // TODO: handle exceptions
      emit(LoginFailure(err));
    }
  }

  Future<void> _onLoginFormChanged(
    LoginFormChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginForm.of(
      email: event.id ?? '',
      password: event.password ?? '',
    ));
  }
}

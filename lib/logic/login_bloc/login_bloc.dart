import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState.init()) {
    on<LoginRequested>(_onLoginRequested);
    on<LoginFormChanged>(_onLoginFormChanged);
  }

  Future<void> _onLoginRequested(LoginRequested event,
      Emitter<LoginState> emit,) async {
    try {
      emit(state.copyWith(
        response: const LoginPending(),
      ));

      final Account account = await authRepository.login(
        state.username,
        state.password,
      );

      emit(state.copyWith(
        response: LoginSuccess(
          account: account.copyWith(
            lastLogin: DateTime.now(),
          ),
        ),
      ));
    } on Exception catch (err) {
      emit(state.copyWith(
        response: LoginFailure(
          exception: err,
        ),
      ));
    } catch (_) {
      emit(state.copyWith(
        response: LoginFailure(
          exception: Exception('Login request error'),
        ),
      ));
    }
  }

  Future<void> _onLoginFormChanged(LoginFormChanged event,
      Emitter<LoginState> emit,) async {
    emit(state.copyWith(
      username: event.username,
      password: event.password,
    ));
  }
}

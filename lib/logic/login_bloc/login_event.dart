part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginFormChanged extends LoginEvent {
  final String? id;
  final String? password;

  const LoginFormChanged({
    this.id,
    this.password,
  });
}

class LoginRequested extends LoginEvent {
  const LoginRequested();
}

class LoginRequestedWithSuccess extends LoginEvent {
  final Account account;

  const LoginRequestedWithSuccess(this.account);
}

class LoginRequestedWithFailure extends LoginEvent {
  final Exception exception;

  const LoginRequestedWithFailure(this.exception);
}

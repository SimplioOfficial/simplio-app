part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginForm extends LoginState {
  final String email;
  final String password;

  const LoginForm._(this.email, this.password);

  const LoginForm.empty() : this._('', '');

  const LoginForm.of({
    required String email,
    required String password,
  }) : this._(email, password);

  @override
  List<Object?> get props => [email, password];

  LoginForm copyWith({String? email, String? password}) => LoginForm._(
        email ?? this.email,
        password ?? this.password,
      );
}

class LoginSuccess extends LoginState {
  final Account account;

  const LoginSuccess(this.account);

  @override
  List<Object?> get props => [account];
}

class LoginFailure extends LoginState {
  final Exception error;

  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

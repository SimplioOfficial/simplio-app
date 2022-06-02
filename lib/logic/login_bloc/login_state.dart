part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final LoginResponse? response;

  const LoginState._({
    required this.username,
    required this.password,
    this.response,
  });

  const LoginState.init() : this._(username: '', password: '');

  @override
  List<Object?> get props => [
        username,
        password,
        response,
      ];

  LoginState copyWith({
    String? username,
    String? password,
    LoginResponse? response,
  }) =>
      LoginState._(
        username: username ?? this.username,
        password: password ?? this.password,
        response: response ?? this.response,
      );
}

abstract class LoginResponse extends Equatable {
  const LoginResponse();
}

class LoginPending extends LoginResponse {
  const LoginPending();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginResponse {
  final Account account;

  const LoginSuccess({required this.account});

  @override
  List<Object?> get props => [account];
}

class LoginFailure extends LoginResponse {
  final Exception exception;

  const LoginFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

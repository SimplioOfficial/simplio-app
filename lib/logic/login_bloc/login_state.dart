part of 'login_bloc.dart';

// abstract class LoginState extends Equatable {
//   const LoginState();
// }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginResponse? response;

  const LoginState._({
    required this.email,
    required this.password,
    this.response,
  });

  const LoginState.init() : this._(email: '', password: '');

  const LoginState.of({
    required String email,
    required String password,
  }) : this._(email: email, password: password);

  @override
  List<Object?> get props => [email, password, response];

  LoginState copyWith({
    String? email,
    String? password,
    LoginResponse? response,
  }) =>
      LoginState._(
        email: email ?? this.email,
        password: password ?? this.password,
        response: response ?? this.response,
      );
}

abstract class LoginResponse extends Equatable {
  const LoginResponse();
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

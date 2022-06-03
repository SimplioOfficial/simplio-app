part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginFormChanged extends LoginEvent {
  final String? username;
  final String? password;

  const LoginFormChanged({
    this.username,
    this.password,
  });

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}

class LoginRequested extends LoginEvent {
  const LoginRequested();

  @override
  List<Object?> get props => [];
}

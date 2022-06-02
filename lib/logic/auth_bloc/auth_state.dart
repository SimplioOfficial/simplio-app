part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class Unauthenticated extends AuthState {
  final Exception? error;

  const Unauthenticated({this.error});

  @override
  List<Object?> get props => [error];
}

class Authenticated extends AuthState {
  final String accountId;

  const Authenticated({required this.accountId});

  @override
  List<Object?> get props => [accountId];
}

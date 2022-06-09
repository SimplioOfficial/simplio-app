part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GotAuthenticated extends AuthEvent {
  final String accountId;

  const GotAuthenticated({required this.accountId});

  @override
  List<Object?> get props => [accountId];
}

class GotUnauthenticated extends AuthEvent {
  final Exception? error;

  const GotUnauthenticated({this.error});

  @override
  List<Object?> get props => [error];
}

class GotLastAuthenticated extends AuthEvent {
  @override
  List<Object?> get props => [];
}

part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

class AccountLastRequested extends AccountEvent {}

class AccountRemoved extends AccountEvent {}

class AccountChanged extends AccountEvent {
  final Account account;

  const AccountChanged({required this.account});
}

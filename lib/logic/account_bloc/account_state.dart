part of 'account_bloc.dart';

enum AccountStatus {
  unauthenticated,
  authenticated,
}

abstract class AccountState extends Equatable {
  const AccountState();
}

class Accounts extends AccountState {
  final Account? account;
  final AccountStatus status;

  const Accounts._({
    required this.account,
    required this.status,
  });

  const Accounts.unauthenticated()
      : this._(account: null, status: AccountStatus.unauthenticated);

  const Accounts.authenticated(Account account)
      : this._(account: account, status: AccountStatus.authenticated);

  @override
  List<Object?> get props => [
        account,
        status,
      ];

  AccountWallet? get accountWallet => account?.wallets
      .firstWhere((element) => element.uuid == account?.defaultWallet);

  bool get isAuthenticated => account != null;
}

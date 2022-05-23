part of 'account_bloc.dart';

enum AccountStatus {
  unauthenticated,
  authenticated,
}

class AccountState extends Equatable {
  final Account? account;
  final AccountStatus status;

  const AccountState._({
    required this.account,
    required this.status,
  });

  const AccountState.unauthenticated()
      : this._(account: null, status: AccountStatus.unauthenticated);

  const AccountState.authenticated(Account account)
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

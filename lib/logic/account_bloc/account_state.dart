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

  AccountWallet? get accountWallet {
    final a = account;
    if (a == null) return null;

    if (a.wallets.isEmpty) return null;

    return a.wallets[0];
  }

  bool get isAuthenticated => account != null;
}

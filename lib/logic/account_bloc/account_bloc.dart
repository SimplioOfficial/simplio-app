import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({required this.accountRepository})
      : super(const AccountState.unauthenticated()) {
    on<AccountLastRequested>(_onAccountLastRequested);
    on<AccountChanged>(_onAccountChanged);
    on<AccountRemoved>(_onAccountRemoved);
  }

  Future<void> _onAccountChanged(
    AccountChanged event,
    Emitter<AccountState> emit,
  ) async {
    final account = await accountRepository.save(event.account);
    emit(AccountState.authenticated(account));
  }

  Future<void> _onAccountRemoved(
    AccountRemoved event,
    Emitter<AccountState> emit,
  ) async {
    final account = state.account;
    if (account == null) return;

    await accountRepository.logout(account);
    emit(const AccountState.unauthenticated());
  }

  void _onAccountLastRequested(
    AccountLastRequested event,
    Emitter<AccountState> emit,
  ) {
    final Account? account = accountRepository.latest();

    emit(
      account != null
          ? AccountState.authenticated(account)
          : const AccountState.unauthenticated(),
    );
  }
}

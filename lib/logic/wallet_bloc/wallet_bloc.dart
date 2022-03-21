import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/data/model/wallet_project.dart';

part 'wallet_state.dart';

part 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const Wallets()) {
    on<AddOrEnableWallet>(_onAddOrEnableWallet);
    on<DisableWallet>(_onDisableWallet);
  }

  // On wallet creation we only add/create a new wallet if it was not yet added
  // In case it was it can get only back enabled or disabled.
  void _onAddOrEnableWallet(AddOrEnableWallet ev, Emitter<WalletState> emit) {
    final state = this.state;
    if (state is! Wallets) return;

    final List<Wallet> all = List.from(state.all);

    final List<String> existing = all
        .where((w) => w.project.ticker == ev.wallet.project.ticker)
        .map((w) => w.uuid)
        .toList();

    if (existing.isEmpty) {
      return emit(Wallets(all: all..add(ev.wallet)));
    }

    final List<Wallet> enabled = all
        .map((w) => existing.contains(w.uuid) ? w.copyWith(enabled: true) : w)
        .toList();

    emit(Wallets(all: enabled));
  }

  // In case a wallet already exists it can be only disabled and not deleted.
  void _onDisableWallet(DisableWallet ev, Emitter<WalletState> emit) {
    final state = this.state;

    if (state is! Wallets) return;

    var disabled = state.all.map((w) => (w.project.ticker == ev.project.ticker)
        ? w.copyWith(enabled: false)
        : w);
    emit(Wallets(all: disabled.toList()));
  }
}
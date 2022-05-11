import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/data/model/asset.dart';

part 'wallet_event.dart';

part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const Wallets()) {
    on<WalletAddedOrEnabled>(_onWalletAddedOrEnabled);
    on<WalletDisabled>(_onWalletDisabled);
  }

  // On wallet creation we only add/create a new wallet if it was not yet added
  // In case it was it can get only back enabled or disabled.
  void _onWalletAddedOrEnabled(
      WalletAddedOrEnabled ev, Emitter<WalletState> emit) {
    final state = this.state;
    if (state is! Wallets) return;

    final List<Wallet> all = List.from(state.wallets);

    final List<String> existing = all
        .where((w) => w.asset.ticker == ev.wallet.asset.ticker)
        .map((w) => w.uuid)
        .toList();

    if (existing.isEmpty) {
      return emit(Wallets(wallets: all..add(ev.wallet)));
    }

    final List<Wallet> enabled = all
        .map((w) => existing.contains(w.uuid) ? w.copyWith(enabled: true) : w)
        .toList();

    emit(Wallets(wallets: enabled));
  }

  // In case a wallet already exists it can be only disabled and not deleted.
  void _onWalletDisabled(WalletDisabled ev, Emitter<WalletState> emit) {
    final state = this.state;

    if (state is! Wallets) return;

    var disabled = state.wallets.map((w) =>
        (w.asset.ticker == ev.asset.ticker) ? w.copyWith(enabled: false) : w);
    emit(Wallets(wallets: disabled.toList()));
  }
}

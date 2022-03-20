import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';

part 'wallet_state.dart';

part 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const Wallets()) {
    on<AddWallet>(_onAddWallet);
  }

  void _onAddWallet(AddWallet ev, Emitter<WalletState> emit) {
    final state = this.state;

    if (state is Wallets) {
      emit(Wallets(all: List.from(state.all)..add(ev.wallet)));
    }
  }
}
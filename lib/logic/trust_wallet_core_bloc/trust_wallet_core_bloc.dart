import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

part 'trust_wallet_core_state.dart';

part 'trust_wallet_core_event.dart';

class TrustWalletCoreBloc
    extends Bloc<TrustWalletCoreEvent, TrustWalletCoreState> {
  TrustWalletCoreBloc() : super(const TrustWalletCore()) {
    on<TrustWalletCoreSet>(_onTrustWalletCoreSet);
  }

  void _onTrustWalletCoreSet(TrustWalletCoreSet ev,
      Emitter<TrustWalletCoreState> emit) {
    final state = this.state;
    if (state is! TrustWalletCore) return;

    final HDWallet trustWallet = ev.trustWallet;

    emit(TrustWalletCore(trustWallet: trustWallet));
  }
}

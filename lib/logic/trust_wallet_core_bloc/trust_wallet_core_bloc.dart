import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/trust_wallet_repository.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

part 'trust_wallet_core_state.dart';

part 'trust_wallet_core_event.dart';

class TrustWalletCoreBloc
    extends Bloc<TrustWalletCoreEvent, TrustWalletCoreState> {
  final TrustWalletRepository trustWalletRepository;

  TrustWalletCoreBloc({required this.trustWalletRepository})
      : super(const TrustWalletCoreState()) {
    on<TrustWalletCoreSet>(_onTrustWalletCoreSet);
  }

  void _onTrustWalletCoreSet(
      TrustWalletCoreSet ev, Emitter<TrustWalletCoreState> emit) {
    final state = this.state;

    HDWallet trustWallet = ev.trustWallet;
    trustWalletRepository.trustWallet = trustWallet;

    emit(TrustWalletCoreState(trustWallet: trustWallet));
  }
}

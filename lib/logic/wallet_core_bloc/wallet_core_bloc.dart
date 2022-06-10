import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/repositories/wallet_core_repository.dart';

part 'wallet_core_state.dart';

part 'wallet_core_event.dart';

class WalletCoreBloc extends Bloc<WalletCoreEvent, WalletCoreState> {
  final WalletCoreRepository walletCoreRepository;

  WalletCoreBloc({
    required this.walletCoreRepository,
  }) : super(const WalletCoreState(seed: '')) {
    on<WalletCoreSeedSet>(_onWalletCoreSeedSet);
  }

  void _onWalletCoreSeedSet(
      WalletCoreSeedSet ev, Emitter<WalletCoreState> emit) {
    String seed = ev.seed;
    walletCoreRepository.importSeed(seed: seed);

    emit(WalletCoreState(seed: seed));
  }
}

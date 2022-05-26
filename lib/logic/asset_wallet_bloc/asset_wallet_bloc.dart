import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';

part 'asset_wallet_event.dart';
part 'asset_wallet_state.dart';

class AssetWalletBloc extends Bloc<AssetWalletEvent, AssetWalletState> {
  final AssetWalletRepository assetWalletRepository;

  AssetWalletBloc({required this.assetWalletRepository})
      : super(const AssetWalletState.empty()) {
    on<AssetWalletLoaded>(_onAssetWalletLoaded);
    on<AssetWalletEnabled>(_onAssetWalletEnabled);
    on<AssetWalletDisabled>(_onAssetWalletDisabled);
  }

  void _onAssetWalletLoaded(
    AssetWalletLoaded ev,
    Emitter<AssetWalletState> emit,
  ) {
    final assetWallets = assetWalletRepository.load(ev.accountWalletId);
    emit(AssetWalletState.loaded(assetWallets));
  }

  Future<void> _onAssetWalletEnabled(
    AssetWalletEnabled ev,
    Emitter<AssetWalletState> emit,
  ) async {
    await assetWalletRepository.enable(ev.accountWalletId, ev.assetId);

    final assetWallets = assetWalletRepository.load(ev.accountWalletId);

    emit(AssetWalletState.loaded(assetWallets));
  }

  Future<void> _onAssetWalletDisabled(
    AssetWalletDisabled ev,
    Emitter<AssetWalletState> emit,
  ) async {
    await assetWalletRepository.disable(ev.accountWalletId, ev.assetId);

    final assetWallets = assetWalletRepository.load(ev.accountWalletId);

    emit(AssetWalletState.loaded(assetWallets));
  }
}

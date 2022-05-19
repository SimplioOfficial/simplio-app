import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';

part 'asset_wallet_event.dart';
part 'asset_wallet_state.dart';

class AssetWalletBloc extends Bloc<AssetWalletEvent, AssetWalletState> {
  AssetWalletBloc() : super(const AssetWalletsLoadingState()) {
    on<AssetWalletLoad>((event, emit) => null);
    on<AssetWalletEnabled>(_onAssetWalletEnabled);
    on<AssetWalletDisabled>(_onAssetWalletDisabled);
  }

  // On wallet creation we only add/create a new wallet if it was not yet added
  // In case it was it can get only back enabled or disabled.
  void _onAssetWalletEnabled(
      AssetWalletEnabled ev, Emitter<AssetWalletState> emit) {}

  // In case a wallet already exists it can be only disabled and not deleted.
  void _onAssetWalletDisabled(
      AssetWalletDisabled ev, Emitter<AssetWalletState> emit) {}
}

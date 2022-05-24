import 'package:bloc/bloc.dart';
import 'package:crypto_assets/crypto_assets.dart';
import 'package:equatable/equatable.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';

part 'asset_toggle_state.dart';

class AssetToggleCubit extends Cubit<AssetToggleState> {
  AssetToggleCubit() : super(const AssetToggleState());

  List<AssetToggle> loadToggles(
      List<MapEntry<String, Asset>> assets, List<AssetWallet> enabled) {
    final toggles = assets
        .map((a) => AssetToggle(
              assetEntry: a,
              toggled: enabled.contains(a),
            ))
        .toList();

    emit(AssetToggleState.success(toggles));

    return state.toggles;
  }
}

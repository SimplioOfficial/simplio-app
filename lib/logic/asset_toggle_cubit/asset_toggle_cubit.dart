import 'package:bloc/bloc.dart';
import 'package:crypto_assets/crypto_assets.dart';
import 'package:equatable/equatable.dart';

part 'asset_toggle_state.dart';

class AssetToggleCubit extends Cubit<AssetToggleState> {
  AssetToggleCubit() : super(const AssetToggleState());

  List<AssetToggle> loadToggles(List<Asset> assets, List<Asset> enabled) {
    final toggles = assets
        .map((a) => AssetToggle(
              asset: a,
              toggled: enabled.contains(a),
            ))
        .toList();

    emit(AssetToggleState.success(toggles));

    return state.toggles;
  }
}

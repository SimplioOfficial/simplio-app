import 'package:bloc/bloc.dart';
import 'package:crypto_assets/crypto_assets.dart';
import 'package:equatable/equatable.dart';

part 'asset_toggle_state.dart';

class AssetToggleCubit extends Cubit<AssetToggleState> {
  AssetToggleCubit() : super(const AssetToggleState());

  List<AssetToggle> loadToggles(
    List<MapEntry<String, Asset>> assets,
    List<String> enabled,
  ) {
    final toggles = assets
        .map((a) => AssetToggle(
              assetEntry: a,
              toggled: enabled.contains(a.key),
            ))
        .toList();

    emit(AssetToggleState.success(toggles));

    return state.toggles;
  }
}

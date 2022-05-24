part of 'asset_toggle_cubit.dart';

class AssetToggle extends Equatable {
  final bool toggled;
  final MapEntry<String, Asset> assetEntry;

  const AssetToggle({
    this.toggled = false,
    required this.assetEntry,
  });

  @override
  List<Object> get props => [
        toggled,
        assetEntry,
      ];
}

class AssetToggleState extends Equatable {
  final List<AssetToggle> toggles;

  const AssetToggleState({
    this.toggles = const <AssetToggle>[],
  });

  const AssetToggleState.success(List<AssetToggle> toggles)
      : this(toggles: toggles);

  @override
  List<Object> get props => [
        toggles,
      ];
}

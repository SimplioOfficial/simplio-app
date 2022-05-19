part of 'asset_toggle_cubit.dart';

class AssetToggle extends Equatable {
  final bool toggled;
  final Asset asset;

  const AssetToggle({
    this.toggled = false,
    required this.asset,
  });

  @override
  List<Object> get props => [
        toggled,
        asset,
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

part of 'asset_toggle_cubit.dart';

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

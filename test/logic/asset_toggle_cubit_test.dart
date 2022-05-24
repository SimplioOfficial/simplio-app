import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplio_app/config/assets.dart';
import 'package:simplio_app/data/model/asset.dart';
import 'package:simplio_app/logic/asset_toggle_cubit/asset_toggle_cubit.dart';

void main() {
  group('AssetToggleCubit', () {
    AssetToggleCubit assetToggleCubit = AssetToggleCubit();

    test('Initial state of CounterCubit', () {
      expect(assetToggleCubit.state, const AssetToggleState());
    });

    blocTest(
      'Turning assets into <AssetToggle>[] based on enabled assets',
      build: () => assetToggleCubit,
      tearDown: () => assetToggleCubit.close(),
      act: (AssetToggleCubit cubit) => cubit.loadToggles(AssetLists.supported, [
        AssetLists.find(AssetLists.supported, 'SIO'),
      ]),
      expect: () => <AssetToggleState>[
        AssetToggleState.success([
          ...AssetLists.supported
              .map((a) => AssetToggle(toggled: false, asset: a))
              .map((a) =>
                  a.asset == AssetLists.find(AssetLists.supported, 'SIO')
                      ? AssetToggle(toggled: true, asset: a.asset)
                      : a)
              .toList(),
        ])
      ],
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/config/assets.dart';
import 'package:simplio_app/data/model/asset.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/asset_toggle_cubit/asset_toggle_cubit.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';
import 'package:simplio_app/view/widgets/appbar_search.dart';
import 'package:simplio_app/view/widgets/asset_toggle_item.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

const String searchLabel = 'Search assets';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  List<AssetToggle> _loadToggles(BuildContext context) {
    final walletState = context.read<WalletBloc>().state;
    final List<Asset> enabled = (walletState is Wallets)
        ? walletState.enabled.map((e) => e.asset).toList()
        : [];

    return context
        .read<AssetToggleCubit>()
        .loadToggles(Assets.supported, enabled);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetToggleCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (context) {
          _loadToggles(context);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0.4,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                title: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: AppBarSearch<String>(
                    label: searchLabel,
                    onTap: (context) => _loadToggles(context),
                    delegate: _AssetSearchDelegate(
                      assetToggleCubit: context.read<AssetToggleCubit>(),
                      onClose: (_) => _loadToggles(context),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 60.0,
                    horizontal: 20.0,
                  ),
                  child: TextHeader(
                    title: 'Get your favorites.',
                    subtitle: 'Enable assets to add them to your portfolio.',
                  ),
                ),
              ),
              BlocBuilder<AssetToggleCubit, AssetToggleState>(
                  buildWhen: (previous, current) =>
                      previous.toggles != current.toggles,
                  builder: (context, state) =>
                      _SliverAssetToggleList(toggles: state.toggles)),
            ],
          );
        }),
      ),
    );
  }
}

class _AssetSearchDelegate extends SearchDelegate<String> {
  final AssetToggleCubit assetToggleCubit;
  final Function(BuildContext context)? onClose;

  _AssetSearchDelegate({
    required this.assetToggleCubit,
    this.onClose,
  }) : super();

  @override
  String? get searchFieldLabel => searchLabel;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.red,
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 16.0,
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        color: Colors.white,
        elevation: 0.4,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          onClose!(context);
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final filtered = assetToggleCubit.state.toggles
        .where((t) =>
            t.asset.name.toLowerCase().contains(query.toLowerCase()) ||
            t.asset.ticker.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          _SliverAssetToggleList(toggles: filtered),
        ],
      ),
    );
  }
}

class _SliverAssetToggleList extends StatelessWidget {
  final List<AssetToggle> toggles;

  const _SliverAssetToggleList({
    Key? key,
    required this.toggles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => AssetToggleItem(
            key: UniqueKey(),
            asset: toggles[i].asset,
            toggled: toggles[i].toggled,
            onToggle: _toggleAsset(context),
          ),
          childCount: toggles.length,
        ),
      );

  AssetToggleAction _toggleAsset(BuildContext context) =>
      ({required bool value, required Asset asset}) => value
          ? context
              .read<WalletBloc>()
              .add(WalletAddedOrEnabled(wallet: Wallet.generate(asset: asset)))
          : context.read<WalletBloc>().add(WalletDisabled(asset: asset));
}

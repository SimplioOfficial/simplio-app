import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/config/assets.dart';
import 'package:simplio_app/data/model/asset.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';
import 'package:simplio_app/view/widgets/appbar_search.dart';
import 'package:simplio_app/view/widgets/asset_toggle_item.dart';

const String searchLabel = 'Search assets';

class AssetsScreen extends StatelessWidget {
  final List<Asset> assets = Assets.supported;

  const AssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0.4,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: AppBarSearch<String>(
                label: searchLabel,
                delegate: _AssetSearchDelegate(assets: assets),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 60.0,
              horizontal: 20.0,
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Get your favorites.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Text(
                    'Enable assets to add them to your portfolio.',
                    style: TextStyle(color: Colors.black26),
                  ),
                ],
              ),
            ),
          )),
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) => (state is Wallets)
                ? _SliverAssetToggleList(
                    assets: assets,
                    activeAssets: state.enabled.map((w) => w.asset).toList(),
                  )
                : SliverToBoxAdapter(
                    child: Container(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _AssetSearchDelegate extends SearchDelegate<String> {
  final List<Asset> assets;

  _AssetSearchDelegate({
    required this.assets,
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
        onPressed: () => close(context, ''),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    var state = context.read<WalletBloc>().state;
    if (state is! Wallets) return Container();

    final filtered = assets
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.ticker.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          _SliverAssetToggleList(
            assets: filtered,
            activeAssets: state.enabled.map((e) => e.asset).toList(),
          ),
        ],
      ),
    );
  }
}

class _SliverAssetToggleList extends StatelessWidget {
  final List<Asset> assets;
  final List<Asset> activeAssets;

  const _SliverAssetToggleList({
    Key? key,
    required this.assets,
    required this.activeAssets,
  }) : super(key: key);

  @override
  SliverList build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => AssetToggleItem(
          key: UniqueKey(),
          asset: assets[i],
          toggled: activeAssets.contains(assets[i]),
          onToggle: _toggleAsset(context),
        ),
        childCount: assets.length,
      ),
    );
  }

  AssetToggleAction _toggleAsset(BuildContext context) =>
      ({required bool value, required Asset asset}) => value
          ? context
              .read<WalletBloc>()
              .add(WalletAddedOrEnabled(wallet: Wallet.generate(asset: asset)))
          : context.read<WalletBloc>().add(WalletDisabled(asset: asset));
}

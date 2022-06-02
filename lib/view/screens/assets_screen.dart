import 'package:crypto_assets/crypto_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/asset_toggle_cubit/asset_toggle_cubit.dart';
import 'package:simplio_app/view/widgets/appbar_search.dart';
import 'package:simplio_app/view/widgets/asset_toggle_item.dart';
import 'package:simplio_app/view/widgets/text_header.dart';

const String searchLabel = 'Search assets';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  List<AssetToggle> _loadToggles(BuildContext context) {
    final walletState = context.read<AccountCubit>().state.enabledAssetWallets;

    return context.read<AssetToggleCubit>().loadToggles(
          Assets.all.entries.toList(),
          walletState.map((e) => e.assetId).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetToggleCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (context) {
          _loadToggles(context);

          final accountWalletId =
              context.read<AccountCubit>().state.account?.wallets[0];

          return accountWalletId != null
              ? CustomScrollView(
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
                          subtitle:
                              'Enable assets to add them to your portfolio.',
                        ),
                      ),
                    ),
                    BlocBuilder<AssetToggleCubit, AssetToggleState>(
                        buildWhen: (previous, current) =>
                            previous.toggles != current.toggles,
                        builder: (context, state) =>
                            _SliverAssetToggleList(toggles: state.toggles)),
                  ],
                )
              : const Center(
                  child: Text('No account wallet is selected'),
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
            t.assetEntry.value.detail.name
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            t.assetEntry.value.detail.ticker
                .toLowerCase()
                .contains(query.toLowerCase()))
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
            assetEntry: toggles[i].assetEntry,
            toggled: toggles[i].toggled,
            onToggle: _toggleAsset(context),
          ),
          childCount: toggles.length,
        ),
      );

  Future<void> Function({
    required String assetId,
    required bool value,
  }) _toggleAsset(BuildContext context) {
    return ({
      required String assetId,
      required bool value,
    }) async =>
        value
            ? await context.read<AccountCubit>().enableAssetWallet(assetId)
            : await context.read<AccountCubit>().disableAssetWallet(assetId);
  }
}

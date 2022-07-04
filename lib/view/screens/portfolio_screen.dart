import 'package:crypto_assets/crypto_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/widgets/appbar_search.dart';
import 'package:simplio_app/view/widgets/asset_toggle_item.dart';
import 'package:simplio_app/view/widgets/wallet_list_item.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: AppBarSearch<String>(
          delegate: _AssetSearchDelegate.of(context),
          label: context.locale.searchAllAssetsInputLabel,
        ),
      ),
      body: BlocBuilder<AccountCubit, AccountState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          var enabledAssetWallets = state.enabledAssetWallets;

          return Container(
            child: enabledAssetWallets.isEmpty
                ? Center(
                    child: Text(
                      context.locale.noWalletsLabel,
                    ),
                  )
                : ListView.builder(
                    restorationId: UniqueKey().toString(),
                    padding: const EdgeInsets.only(bottom: 100.0),
                    itemCount: enabledAssetWallets.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      final AssetWallet wallet = enabledAssetWallets[i];

                      return WalletListItem(
                        key: Key(wallet.assetId),
                        assetWallet: wallet,
                        onTap: () =>
                            AuthenticatedRoute.key.currentState?.pushNamed(
                          AuthenticatedRoute.wallet,
                          arguments: wallet,
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class _AssetSearchDelegate extends SearchDelegate<String> {
  final BuildContext context;

  _AssetSearchDelegate.of(this.context) : super();

  @override
  String? get searchFieldLabel => context.locale.searchAllAssetsInputLabel;

  @override
  List<Widget>? buildActions(_) => [];

  @override
  Widget? buildLeading(_) {
    return IconButton(
        onPressed: () => close(context, ''),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(_) => buildSuggestions(context);

  @override
  Widget buildSuggestions(_) {
    final List<String> enabled = context
        .read<AccountCubit>()
        .state
        .enabledAssetWallets
        .map((e) => e.assetId)
        .toList();

    final filtered = Assets.enabled.entries
        .where((t) =>
            t.value.detail.name.toLowerCase().contains(query.toLowerCase()) ||
            t.value.detail.ticker.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (_, i) => AssetToggleItem(
        key: UniqueKey(),
        assetEntry: filtered[i],
        isEnabled: enabled.contains(filtered[i].key),
        onChange: (value, assetId) => value
            ? context.read<AccountCubit>().enableAssetWallet(assetId)
            : context.read<AccountCubit>().disableAssetWallet(assetId),
      ),
    );
  }
}

part of 'asset_wallet_bloc.dart';

enum AssetWalletStatus {
  loading,
  loaded,
}

class AssetWalletState extends Equatable {
  final List<AssetWallet> assetWallets;
  final AssetWalletStatus status;

  const AssetWalletState._({
    required this.assetWallets,
    required this.status,
  });

  const AssetWalletState.empty()
      : this._(
          assetWallets: const <AssetWallet>[],
          status: AssetWalletStatus.loaded,
        );

  const AssetWalletState.loading()
      : this._(
          assetWallets: const <AssetWallet>[],
          status: AssetWalletStatus.loading,
        );

  const AssetWalletState.loaded(List<AssetWallet> assetWallets)
      : this._(
          assetWallets: assetWallets,
          status: AssetWalletStatus.loaded,
        );

  List<AssetWallet> get enabled =>
      assetWallets.where((w) => w.isEnabled).toList();

  @override
  List<Object?> get props => [
        assetWallets,
        status,
      ];
}

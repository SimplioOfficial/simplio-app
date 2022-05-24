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

  @override
  List<Object?> get props => [];

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
      assetWallets.where((element) => element.enabled).toList();
}

// class AssetWalletsLoadingState extends AssetWalletState {
//   const AssetWalletsLoadingState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class AssetWallets extends AssetWalletState {
//   final List<AssetWallet> wallets;
//
//   const AssetWallets({
//     required this.wallets,
//   });
//
//   @override
//   List<Object?> get props => [
//         wallets,
//       ];
//
//   List<AssetWallet> get enabled =>
//       wallets.where((wallet) => wallet.enabled).toList();
// }

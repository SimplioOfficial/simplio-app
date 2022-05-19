part of 'asset_wallet_bloc.dart';

abstract class AssetWalletState extends Equatable {
  const AssetWalletState();
}

class AssetWalletsLoadingState extends AssetWalletState {
  const AssetWalletsLoadingState();

  @override
  List<Object?> get props => [];
}

class AssetWallets extends AssetWalletState {
  final List<AssetWallet> wallets;

  const AssetWallets({
    required this.wallets,
  });

  @override
  List<Object?> get props => [
        wallets,
      ];

  List<AssetWallet> get enabled =>
      wallets.where((wallet) => wallet.enabled).toList();
}

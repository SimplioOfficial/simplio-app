part of 'asset_wallet_bloc.dart';

abstract class AssetWalletEvent extends Equatable {
  const AssetWalletEvent();
}

class AssetWalletLoad extends AssetWalletEvent {
  final String accountWalletId;

  const AssetWalletLoad({required this.accountWalletId});

  @override
  List<Object?> get props => [accountWalletId];
}

class AssetWalletLoadSuccess extends AssetWalletEvent {
  final List<AssetWallet> wallets;

  const AssetWalletLoadSuccess({required this.wallets});

  @override
  List<Object?> get props => [wallets];
}

class AssetWalletLoadFailure extends AssetWalletEvent {
  // final Error exception
  const AssetWalletLoadFailure();

  @override
  List<Object?> get props => [];
}

class AssetWalletEnabled extends AssetWalletEvent {
  final AssetWallet wallet;

  const AssetWalletEnabled({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

class AssetWalletDisabled extends AssetWalletEvent {
  final AssetWallet asset;

  const AssetWalletDisabled({required this.asset});

  @override
  List<Object?> get props => [asset];
}

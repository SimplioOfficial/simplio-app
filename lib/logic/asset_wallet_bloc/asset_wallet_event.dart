part of 'asset_wallet_bloc.dart';

abstract class AssetWalletEvent extends Equatable {
  const AssetWalletEvent();
}

class AssetWalletLoaded extends AssetWalletEvent {
  final String accountWalletId;

  const AssetWalletLoaded({required this.accountWalletId});

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
  final String accountWalletId;
  final String assetId;

  const AssetWalletEnabled({
    required this.accountWalletId,
    required this.assetId,
  });

  @override
  List<Object?> get props => [
        assetId,
        accountWalletId,
      ];
}

// TODO: Target uuid
class AssetWalletDisabled extends AssetWalletEvent {
  final String accountWalletId;
  final String assetId;

  const AssetWalletDisabled({
    required this.assetId,
    required this.accountWalletId,
  });

  @override
  List<Object?> get props => [
        assetId,
        accountWalletId,
      ];
}

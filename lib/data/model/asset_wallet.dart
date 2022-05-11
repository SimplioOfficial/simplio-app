import 'package:equatable/equatable.dart';
import 'package:simplio_app/data/model/asset.dart';
import 'package:simplio_app/data/model/wallet.dart';

class AssetWallet extends Equatable {
  final String ticker;
  final String accountWalletId;
  final Asset asset;
  final bool enabled;
  final List<Wallet> wallets;

  const AssetWallet._(
    this.ticker,
    this.accountWalletId,
    this.asset,
    this.enabled,
    this.wallets,
  );

  const AssetWallet.builder({
    required String assetId,
    required String accountWalletId,
    required Asset asset,
    required bool enabled,
    required List<Wallet> wallets,
  }) : this._(
          assetId,
          accountWalletId,
          asset,
          enabled,
          wallets,
        );

  @override
  List<Object?> get props => [
        ticker,
      ];
}

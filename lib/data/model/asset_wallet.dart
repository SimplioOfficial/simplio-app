import 'package:crypto_assets/crypto_assets.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/wallet.dart';

part 'asset_wallet.g.dart';

class AssetWallet extends Equatable {
  final String accountWalletId;
  final String assetId;
  final bool enabled;
  final List<Wallet> wallets;

  const AssetWallet._({
    required this.accountWalletId,
    required this.assetId,
    required this.enabled,
    required this.wallets,
  });

  const AssetWallet.builder({
    required String accountWalletId,
    required String assetId,
    bool enabled = true,
    required List<Wallet> wallets,
  }) : this._(
          accountWalletId: accountWalletId,
          assetId: assetId,
          enabled: enabled,
          wallets: wallets,
        );

  Asset get asset => Assets.all[assetId]!;

  @override
  List<Object?> get props => [
        accountWalletId,
        enabled,
        wallets,
      ];
}

@HiveType(typeId: 4)
class AssetWalletLocal extends HiveObject {
  @HiveField(0)
  final String accountWalletId;

  @HiveField(1)
  final String assetId;

  @HiveField(2)
  final bool enabled;

  @HiveField(3)
  final HiveList<WalletLocal> wallets;

  AssetWalletLocal(
    this.accountWalletId,
    this.assetId,
    this.enabled,
    this.wallets,
  );
}

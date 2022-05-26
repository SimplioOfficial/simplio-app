import 'package:crypto_assets/crypto_assets.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:uuid/uuid.dart';

part 'asset_wallet.g.dart';

class AssetWallet extends Equatable {
  final String uuid;
  final String accountWalletId;
  final String assetId;
  final bool isEnabled;
  final List<Wallet> wallets;

  const AssetWallet._({
    required this.uuid,
    required this.accountWalletId,
    required this.assetId,
    required this.isEnabled,
    required this.wallets,
  });

  AssetWallet.builder({
    String? uuid,
    required String accountWalletId,
    required String assetId,
    bool isEnabled = true,
    required List<Wallet> wallets,
  }) : this._(
          uuid: uuid ?? const Uuid().v4(),
          accountWalletId: accountWalletId,
          assetId: assetId,
          isEnabled: isEnabled,
          wallets: wallets,
        );

  Asset get asset => Assets.all[assetId]!;

  @override
  List<Object?> get props => [
        assetId,
        accountWalletId,
        isEnabled,
        wallets,
      ];

  AssetWallet copyWith({
    bool? isEnabled,
  }) {
    return AssetWallet._(
      uuid: uuid,
      accountWalletId: accountWalletId,
      assetId: assetId,
      isEnabled: isEnabled ?? this.isEnabled,
      wallets: wallets,
    );
  }
}

@HiveType(typeId: 4)
class AssetWalletLocal extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String accountWalletId;

  @HiveField(2)
  final String assetId;

  @HiveField(3)
  final bool isEnabled;

  @HiveField(4)
  final List<WalletLocal> wallets;

  AssetWalletLocal({
    required this.uuid,
    required this.accountWalletId,
    required this.assetId,
    required this.isEnabled,
    required this.wallets,
  });
}

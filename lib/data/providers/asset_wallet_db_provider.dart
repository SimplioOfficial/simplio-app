import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/data/providers/box_provider.dart';

class AssetWalletDbProvider extends BoxProvider<AssetWalletLocal> {
  static final AssetWalletDbProvider _instance = AssetWalletDbProvider._();

  @override
  final String boxName = 'assetWalletBox';

  AssetWalletDbProvider._();

  factory AssetWalletDbProvider() {
    return _instance;
  }

  @override
  void registerAdapters() {
    Hive.registerAdapter(AssetWalletLocalAdapter());
    Hive.registerAdapter(WalletLocalAdapter());
  }

  AssetWallet? get(String uuid) {
    try {
      final AssetWalletLocal? assetWalletLocal = box.get(uuid);

      return assetWalletLocal != null ? _mapTo(assetWalletLocal) : null;
    } catch (_) {
      return null;
    }
  }

  AssetWallet? find(String accountWalletId, String assetId) {
    try {
      final assetWallet = box.values.firstWhere(
        (w) => w.accountWalletId == accountWalletId && w.assetId == assetId,
      );

      return _mapTo(assetWallet);
    } catch (_) {
      return null;
    }
  }

  List<AssetWallet> findAll(String accountWalletId) {
    try {
      return box.values
          .where((w) => w.accountWalletId == accountWalletId)
          .map((e) => _mapTo(e))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<AssetWallet> save(AssetWallet assetWallet) async {
    await box.put(assetWallet.uuid, _mapFrom(assetWallet));
    return assetWallet;
  }

  AssetWalletLocal _mapFrom(AssetWallet assetWallet) {
    return AssetWalletLocal(
      uuid: assetWallet.uuid,
      accountWalletId: assetWallet.accountWalletId,
      assetId: assetWallet.assetId,
      isEnabled: assetWallet.isEnabled,
      wallets: assetWallet.wallets
          .map((w) => WalletLocal(
                uuid: w.uuid,
                coinType: w.coinType,
                derivationPath: w.derivationPath,
                balance: w.balance,
              ))
          .toList(),
    );
  }

  AssetWallet _mapTo(AssetWalletLocal assetWalletLocal) {
    return AssetWallet.builder(
      uuid: assetWalletLocal.uuid,
      accountWalletId: assetWalletLocal.accountWalletId,
      assetId: assetWalletLocal.assetId,
      isEnabled: assetWalletLocal.isEnabled,
      wallets: assetWalletLocal.wallets
          .map((w) => Wallet.builder(
                coinType: w.coinType,
                balance: w.balance,
                derivationPath: w.derivationPath,
              ))
          .toList(),
    );
  }
}

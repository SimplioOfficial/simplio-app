import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/model/wallet.dart';

class AssetWalletDbProvider {
  static const assetWalletBoxName = 'assetWalletBox';
  late final Box<AssetWalletLocal> _assetWalletBox;

  AssetWalletDbProvider();

  Future<AssetWalletDbProvider> init() async {
    Hive.registerAdapter(AssetWalletLocalAdapter());
    Hive.registerAdapter(WalletLocalAdapter());

    _assetWalletBox = await Hive.openBox<AssetWalletLocal>(assetWalletBoxName);

    // TODO - remove. Clear is for testing purposes only.
    // await _assetWalletBox.clear();

    return this;
  }

  AssetWallet? get(String uuid) {
    try {
      final AssetWalletLocal? assetWalletLocal = _assetWalletBox.get(uuid);

      return assetWalletLocal != null ? _to(assetWalletLocal) : null;
    } on Exception {
      return null;
    }
  }

  AssetWallet? find(String accountWalletId, String assetId) {
    try {
      final assetWallet = _assetWalletBox.values.firstWhere(
          (w) => w.accountWalletId == accountWalletId && w.assetId == assetId);

      return _to(assetWallet);
    } catch (e) {
      print(e);
      return null;
    }
  }

  List<AssetWallet> findAll(String accountWalletId) {
    try {
      return _assetWalletBox.values
          .where((w) => w.accountWalletId == accountWalletId)
          .map((e) => _to(e))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<AssetWallet> save(AssetWallet assetWallet) async {
    final _ = await _assetWalletBox.put(assetWallet.uuid, _from(assetWallet));

    return assetWallet;
  }

  AssetWalletLocal _from(AssetWallet assetWallet) {
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

  AssetWallet _to(AssetWalletLocal assetWalletLocal) {
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

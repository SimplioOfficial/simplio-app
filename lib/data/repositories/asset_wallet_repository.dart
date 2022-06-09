import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';

class AssetWalletRepository {
  final AssetWalletDbProvider _db;

  const AssetWalletRepository._(this._db);

  const AssetWalletRepository.builder({
    required AssetWalletDbProvider db,
  }) : this._(db);

  Future<AssetWalletRepository> init() async {
    await _db.init();

    return this;
  }

  List<AssetWallet> load(String accountWalletId) {
    return _db.findAll(accountWalletId);
  }

  Future<AssetWallet> enable(String accountWalletId, String assetId) async {
    try {
      final existingAssetWallet = _db.find(accountWalletId, assetId);

      if (existingAssetWallet != null) {
        return _db.save(existingAssetWallet.copyWith(isEnabled: true));
      }

      final assetWallet = AssetWallet.builder(
        accountWalletId: accountWalletId,
        assetId: assetId,
        wallets: const [],
      );

      return _db.save(assetWallet);
    } catch (_) {
      throw Exception("Asset wallet of $assetId could not be enabled");
    }
  }

  Future<void> disable(String accountWalletId, String assetId) async {
    try {
      final existingAssetWallet = _db.find(accountWalletId, assetId);

      if (existingAssetWallet == null) return;

      await _db.save(existingAssetWallet.copyWith(isEnabled: false));
    } catch (_) {
      throw Exception("Asset wallet of $assetId could not be disabled");
    }
  }

  Future<AssetWallet> save(AssetWallet assetWallet) async {
    return await _db.save(assetWallet);
  }

  AssetWallet? get(String uuid) {
    return _db.get(uuid);
  }
}

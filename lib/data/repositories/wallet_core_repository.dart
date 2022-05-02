import 'package:simplio_app/data/interfaces/wallet_core_provider_interface.dart';

class WalletCoreRepository {
  late WalletCoreProviderInterface? _walletCore;

  WalletCoreRepository._(this._walletCore);

  WalletCoreRepository.builder(
      {required WalletCoreProviderInterface trustWallet})
      : this._(trustWallet);

  String generateSeed() {
    if (_walletCore != null) {
      return _walletCore!.generateSeed();
    }
    throw Exception('_walletCore is not initialized');
  }

  String get seed => _walletCore?.seed ?? '';

  String getAddress(int coinType) => _walletCore?.address(coinType) ?? '';

  void importSeed({required String seed}) {
    return _walletCore?.importSeed(seed: seed);
  }
}

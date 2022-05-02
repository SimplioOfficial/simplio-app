abstract class WalletCoreProviderInterface {
  void importSeed({required String seed});

  String? get seed;

  String generateSeed();

  String? address(int coinType);
}

abstract class WalletCoreProviderInterface {
  void importSeed({required String seed});

  String? get seed;

  String generateSeed();

// More to come...
}

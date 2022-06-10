import 'package:simplio_app/data/interfaces/wallet_core_provider_interface.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:sio_core/sio_core.dart' as sio;

class TrustWalletCoreProvider extends WalletCoreProviderInterface {
  static final TrustWalletCoreProvider _instance = TrustWalletCoreProvider._();
  HDWallet? _trustWallet;

  TrustWalletCoreProvider._();

  factory TrustWalletCoreProvider() {
    return _instance;
  }

  @override
  void importSeed({required String seed}) {
    _trustWallet = HDWallet.createWithMnemonic(seed);
  }

  @override
  String? get seed => _trustWallet?.mnemonic();

  @override
  String generateSeed() => sio.Mnemonic().generate;
}

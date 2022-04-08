import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';

class BlocProviders {
  static final WalletBloc walletBloc = WalletBloc();
  static final TrustWalletCoreBloc trustWalletCoreBloc = TrustWalletCoreBloc();
}

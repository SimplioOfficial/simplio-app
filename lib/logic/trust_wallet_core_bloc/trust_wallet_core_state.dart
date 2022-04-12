part of 'trust_wallet_core_bloc.dart';

abstract class TrustWalletCoreState extends Equatable {
  const TrustWalletCoreState();
}

class TrustWalletCore extends TrustWalletCoreState {
  final HDWallet? trustWallet;

  const TrustWalletCore({this.trustWallet});

  @override
  List<Object?> get props => [trustWallet];
}

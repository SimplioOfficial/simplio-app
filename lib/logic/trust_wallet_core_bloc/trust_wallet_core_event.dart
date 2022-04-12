part of 'trust_wallet_core_bloc.dart';

abstract class TrustWalletCoreEvent extends Equatable {
  const TrustWalletCoreEvent();
}

class TrustWalletCoreSet extends TrustWalletCoreEvent {
  final HDWallet trustWallet;

  const TrustWalletCoreSet({required this.trustWallet});

  @override
  List<Object?> get props => [trustWallet];
}

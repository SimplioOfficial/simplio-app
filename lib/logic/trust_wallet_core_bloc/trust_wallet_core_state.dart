part of 'trust_wallet_core_bloc.dart';

class TrustWalletCoreState extends Equatable {
  final HDWallet? trustWallet;

  const TrustWalletCoreState({this.trustWallet});

  @override
  List<Object?> get props => [trustWallet];
}

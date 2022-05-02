part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class WalletAddedOrEnabled extends WalletEvent {
  final Wallet wallet;

  const WalletAddedOrEnabled({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

class WalletDisabled extends WalletEvent {
  final Asset asset;

  const WalletDisabled({required this.asset});

  @override
  List<Object?> get props => [asset];
}

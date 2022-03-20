part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class AddOrEnableWallet extends WalletEvent {
  final Wallet wallet;

  const AddOrEnableWallet({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

class DisableWallet extends WalletEvent {
  final WalletProject project;

  const DisableWallet({required this.project});

  @override
  List<Object?> get props => [project];
}
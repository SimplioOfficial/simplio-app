part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class AddOrActivateWallet extends WalletEvent {
  final Wallet wallet;

  const AddOrActivateWallet({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

class DeactivateProject extends WalletEvent {
  final WalletProject project;

  const DeactivateProject({required this.project});

  @override
  List<Object?> get props => [project];
}
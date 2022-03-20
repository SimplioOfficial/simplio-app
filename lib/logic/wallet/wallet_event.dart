part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class AddWallet extends WalletEvent {
  final Wallet wallet;

  const AddWallet({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}
part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class Wallets extends WalletState {
  final List<Wallet> wallets;

  const Wallets({this.wallets = const <Wallet>[]});

  @override
  List<Object?> get props => [wallets];

  List<Wallet> get enabled =>
      wallets.where((wallet) => wallet.enabled).toList();
}
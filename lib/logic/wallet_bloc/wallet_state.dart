part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class Wallets extends WalletState {
  final List<Wallet> all;

  const Wallets({this.all = const <Wallet>[]});

  @override
  List<Object?> get props => [all];

  List<Wallet> enabled() {
    return all.where((wallet) => wallet.enabled).toList();
  }
}
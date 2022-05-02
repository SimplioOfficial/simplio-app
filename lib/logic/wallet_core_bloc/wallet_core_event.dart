part of 'wallet_core_bloc.dart';

abstract class WalletCoreEvent extends Equatable {
  const WalletCoreEvent();
}

class WalletCoreSeedSet extends WalletCoreEvent {
  final String seed;

  const WalletCoreSeedSet({required this.seed});

  @override
  List<Object?> get props => [seed];
}

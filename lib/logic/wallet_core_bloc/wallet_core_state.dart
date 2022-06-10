part of 'wallet_core_bloc.dart';

class WalletCoreState extends Equatable {
  final String seed;

  const WalletCoreState({required this.seed});

  @override
  List<Object?> get props => [seed];
}

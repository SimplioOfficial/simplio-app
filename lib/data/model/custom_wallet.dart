import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CustomWallet extends Equatable {
  final String uuid;
  final String name;
  final String ticker;
  final String parent;
  final String contractAddress;
  final String accountWalletId;
  final int networkType;
  final bool enabled;
  final BigInt balance;

  const CustomWallet._(
    this.uuid,
    this.name,
    this.ticker,
    this.parent,
    this.contractAddress,
    this.accountWalletId,
    this.networkType,
    this.enabled,
    this.balance,
  );

  CustomWallet.builder({
    required String name,
    required String ticker,
    required String parent,
    required String contractAddress,
    required String accountWalletId,
    required int networkType,
    bool enabled = true,
    required BigInt balance,
  }) : this._(
          const Uuid().v4(),
          name,
          ticker,
          parent,
          contractAddress,
          accountWalletId,
          networkType,
          enabled,
          balance,
        );

  @override
  List<Object?> get props => [
        uuid,
        name,
        ticker,
        contractAddress,
        networkType,
      ];
}

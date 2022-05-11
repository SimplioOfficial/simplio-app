import 'package:equatable/equatable.dart';
import 'package:simplio_app/data/model/network.dart';
import 'package:uuid/uuid.dart';

class Wallet extends Equatable {
  final String uuid;
  final int coinType;
  final Network network;
  final String? derivationPath;
  final BigInt balance;

  const Wallet._(
    this.uuid,
    this.coinType,
    this.network,
    this.derivationPath,
    this.balance,
  );

  Wallet.builder({
    required int coinType,
    required Network network,
    String? derivationPath,
    BigInt? balance,
  }) : this._(
          const Uuid().v4(),
          coinType,
          network,
          derivationPath,
          balance = BigInt.zero,
        );

  @override
  List<Object?> get props => [
        uuid,
        coinType,
      ];
}

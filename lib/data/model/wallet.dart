import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class Wallet extends Equatable {
  final String uuid;
  final int coinType;
  final String? derivationPath;
  final BigInt balance; // 100000000000000000000

  const Wallet._({
    required this.uuid,
    required this.coinType,
    required this.derivationPath,
    required this.balance,
  });

  Wallet.builder({
    required int coinType,
    String? derivationPath,
    BigInt? balance,
  }) : this._(
          uuid: const Uuid().v4(),
          coinType: coinType,
          derivationPath: derivationPath,
          balance: balance ?? BigInt.zero,
        );

  @override
  List<Object?> get props => [
        uuid,
        coinType,
        derivationPath,
        balance,
      ];
}

@HiveField(6)
class WalletLocal extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final int coinType;

  @HiveField(2)
  final String? derivationPath;

  @HiveField(3)
  final BigInt balance;

  WalletLocal(
    this.uuid,
    this.coinType,
    this.derivationPath,
    this.balance,
  );
}

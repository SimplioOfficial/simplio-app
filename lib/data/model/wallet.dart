import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'wallet.g.dart';

class Wallet extends Equatable {
  final String uuid;
  final int coinType;
  final String? derivationPath;
  final BigInt balance;

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

@HiveType(typeId: 5)
class WalletLocal extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final int coinType;

  @HiveField(2)
  final String? derivationPath;

  @HiveField(3)
  final BigInt balance;

  WalletLocal({
    required this.uuid,
    required this.coinType,
    required this.derivationPath,
    required this.balance,
  });
}

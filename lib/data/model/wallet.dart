import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'wallet.g.dart';

class Wallet extends Equatable {
  final String uuid;
  final int coinType;
  final BigInt balance;
  final String? derivationPath;

  // TODO: Remove & refactor this when backend proxy endpoint is done
  // final String balanceApi;

  const Wallet._({
    required this.uuid,
    required this.coinType,
    required this.balance,
    required this.derivationPath,
    // required this.balanceApi,
  });

  Wallet.builder({
    required int coinType,
    // required String balanceApi,
    String? derivationPath,
    BigInt? balance,
  }) : this._(
          uuid: const Uuid().v4(),
          coinType: coinType,
          derivationPath: derivationPath,
          balance: balance ?? BigInt.zero,
          // balanceApi: balanceApi,
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

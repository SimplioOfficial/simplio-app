import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 6)
class CustomWallet extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String ticker;

  @HiveField(3)
  final String parent;

  @HiveField(4)
  final String contractAddress;

  @HiveField(5)
  final String accountWalletId;

  @HiveField(6)
  final int coinType;

  @HiveField(7)
  final bool enabled;

  @HiveField(8)
  final BigInt balance;

  @HiveField(9)
  final int decimal;

  CustomWallet(
    this.uuid,
    this.name,
    this.ticker,
    this.parent,
    this.contractAddress,
    this.accountWalletId,
    this.coinType,
    this.enabled,
    this.balance,
    this.decimal,
  );

  CustomWallet.builder({
    required String name,
    required String ticker,
    required String parent,
    required String contractAddress,
    required String accountWalletId,
    required int coinType,
    bool enabled = true,
    required BigInt balance,
    required int decimal,
  }) : this(
          const Uuid().v4(),
          name,
          ticker,
          parent,
          contractAddress,
          accountWalletId,
          coinType,
          enabled,
          balance,
          decimal,
        );
}

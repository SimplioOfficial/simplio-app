import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class AccountWallet<T extends AccountWalletType> extends Equatable {
  final String name;
  final String uuid;
  final String accountId;
  final T walletType;
  final DateTime updatedAt;

  const AccountWallet._(
    this.name,
    this.uuid,
    this.accountId,
    this.walletType,
    this.updatedAt,
  );

  AccountWallet.builder({
    required String name,
    required String accountId,
    required T walletType,
    bool enabled = true,
    required DateTime updatedAt,
  }) : this._(
          const Uuid().v4(),
          name,
          accountId,
          walletType,
          updatedAt,
        );

  @override
  List<Object?> get props => [
        uuid,
        updatedAt,
      ];

  AccountWallet copyWith({
    String? name,
    bool? enabled,
    DateTime? updatedAt,
  }) {
    return AccountWallet._(
      name ?? this.name,
      uuid,
      accountId,
      walletType,
      updatedAt ?? this.updatedAt,
    );
  }
}

abstract class AccountWalletType {
  final String mnemonic;

  const AccountWalletType({
    required this.mnemonic,
  });
}

class MultiCoinWallet extends AccountWalletType {
  MultiCoinWallet({required String mnemonic}) : super(mnemonic: mnemonic);
}

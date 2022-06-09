import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/mixins/aes_encryption_mixin.dart';
import 'package:uuid/uuid.dart';

part 'account_wallet.g.dart';

class AccountWallet extends Equatable {
  final String name;
  final String uuid;
  final String accountId;
  final LockableSeed seed;
  final AccountWalletTypes walletType;
  final DateTime updatedAt;

  const AccountWallet._({
    required this.uuid,
    required this.name,
    required this.accountId,
    required this.seed,
    required this.walletType,
    required this.updatedAt,
  });

  AccountWallet.builder({
    String? uuid,
    required String name,
    required String accountId,
    required AccountWalletTypes walletType,
    required LockableSeed seed,
    required DateTime updatedAt,
  }) : this._(
          uuid: uuid ?? const Uuid().v4(),
          name: name,
          accountId: accountId,
          seed: seed,
          walletType: walletType,
          updatedAt: updatedAt,
        );

  AccountWallet copyWith({
    String? name,
    DateTime? updatedAt,
  }) {
    return AccountWallet._(
      name: name ?? this.name,
      uuid: uuid,
      accountId: accountId,
      seed: seed,
      walletType: walletType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        name,
        accountId,
        walletType,
        updatedAt,
      ];
}

class LockableSeed with AesEncryption {
  String _mnemonic;
  final bool isImported;
  final bool isBackedUp;
  bool _isLocked;

  LockableSeed._(
    this._mnemonic,
    this.isImported,
    this.isBackedUp,
    this._isLocked,
  );

  LockableSeed.from({
    required String mnemonic,
    required bool isImported,
    required bool isBackedUp,
    bool isLocked = true,
  }) : this._(
          mnemonic,
          isImported,
          isBackedUp,
          isLocked,
        );

  bool get isLocked => _isLocked;

  String unlock(String key) {
    if (!_isLocked) return _mnemonic;
    return decrypt(key, _mnemonic);
  }

  LockableSeed lock(String key) {
    if (_isLocked) return this;

    _mnemonic = encrypt(key, _mnemonic);
    _isLocked = true;

    return this;
  }

  @override
  String toString() {
    return _mnemonic;
  }
}

@HiveType(typeId: 31)
enum AccountWalletTypes {
  @HiveField(0)
  hdWallet,
}

@HiveType(typeId: 3)
class AccountWalletLocal extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String uuid;

  @HiveField(2)
  final String accountId;

  @HiveField(3)
  final String mnemonic;

  @HiveField(4)
  final bool isImported;

  @HiveField(5)
  final bool isBackedUp;

  @HiveField(6)
  final AccountWalletTypes walletType;

  @HiveField(7)
  final DateTime updatedAt;

  AccountWalletLocal({
    required this.uuid,
    required this.name,
    required this.accountId,
    required this.mnemonic,
    required this.isImported,
    required this.isBackedUp,
    required this.walletType,
    required this.updatedAt,
  });
}

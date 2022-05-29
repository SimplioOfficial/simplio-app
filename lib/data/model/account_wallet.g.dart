// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountWalletLocalAdapter extends TypeAdapter<AccountWalletLocal> {
  @override
  final int typeId = 3;

  @override
  AccountWalletLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountWalletLocal(
      uuid: fields[1] as String,
      name: fields[0] as String,
      accountId: fields[2] as String,
      mnemonic: fields[3] as String,
      isImported: fields[4] as bool,
      isBackedUp: fields[5] as bool,
      walletType: fields[6] as AccountWalletTypes,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AccountWalletLocal obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.accountId)
      ..writeByte(3)
      ..write(obj.mnemonic)
      ..writeByte(4)
      ..write(obj.isImported)
      ..writeByte(5)
      ..write(obj.isBackedUp)
      ..writeByte(6)
      ..write(obj.walletType)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountWalletLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountWalletTypesAdapter extends TypeAdapter<AccountWalletTypes> {
  @override
  final int typeId = 31;

  @override
  AccountWalletTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AccountWalletTypes.hdWallet;
      default:
        return AccountWalletTypes.hdWallet;
    }
  }

  @override
  void write(BinaryWriter writer, AccountWalletTypes obj) {
    switch (obj) {
      case AccountWalletTypes.hdWallet:
        writer.writeByte(0);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountWalletTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

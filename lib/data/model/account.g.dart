// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountLocalAdapter extends TypeAdapter<AccountLocal> {
  @override
  final int typeId = 1;

  @override
  AccountLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountLocal(
      id: fields[0] as String,
      secret: fields[1] as String,
      refreshToken: fields[2] as String,
      lastLogin: fields[3] as DateTime,
      settings: fields[4] as AccountSettingsLocal,
      wallets: (fields[5] as List).cast<AccountWalletLocal>(),
    );
  }

  @override
  void write(BinaryWriter writer, AccountLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.secret)
      ..writeByte(2)
      ..write(obj.refreshToken)
      ..writeByte(3)
      ..write(obj.lastLogin)
      ..writeByte(4)
      ..write(obj.settings)
      ..writeByte(5)
      ..write(obj.wallets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

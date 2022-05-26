// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletLocalAdapter extends TypeAdapter<WalletLocal> {
  @override
  final int typeId = 5;

  @override
  WalletLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletLocal(
      uuid: fields[0] as String,
      coinType: fields[1] as int,
      derivationPath: fields[2] as String?,
      balance: fields[3] as BigInt,
    );
  }

  @override
  void write(BinaryWriter writer, WalletLocal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.coinType)
      ..writeByte(2)
      ..write(obj.derivationPath)
      ..writeByte(3)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

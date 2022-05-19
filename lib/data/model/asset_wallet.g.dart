// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetWalletLocalAdapter extends TypeAdapter<AssetWalletLocal> {
  @override
  final int typeId = 4;

  @override
  AssetWalletLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetWalletLocal(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
      (fields[3] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, AssetWalletLocal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.accountWalletId)
      ..writeByte(1)
      ..write(obj.assetId)
      ..writeByte(2)
      ..write(obj.enabled)
      ..writeByte(3)
      ..write(obj.wallets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetWalletLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

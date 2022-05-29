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
      uuid: fields[0] as String,
      accountWalletId: fields[1] as String,
      assetId: fields[2] as String,
      isEnabled: fields[3] as bool,
      wallets: (fields[4] as List).cast<WalletLocal>(),
    );
  }

  @override
  void write(BinaryWriter writer, AssetWalletLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.accountWalletId)
      ..writeByte(2)
      ..write(obj.assetId)
      ..writeByte(3)
      ..write(obj.isEnabled)
      ..writeByte(4)
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

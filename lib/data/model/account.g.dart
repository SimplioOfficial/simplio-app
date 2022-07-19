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
      accountType: fields[1] as AccountType,
      secret: fields[2] as String,
      securityLevel: fields[3] as SecurityLevel,
      signedIn: fields[4] as DateTime,
      settings: fields[5] as AccountSettingsLocal,
      wallets: (fields[6] as List).cast<AccountWalletLocal>(),
    );
  }

  @override
  void write(BinaryWriter writer, AccountLocal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountType)
      ..writeByte(2)
      ..write(obj.secret)
      ..writeByte(3)
      ..write(obj.securityLevel)
      ..writeByte(4)
      ..write(obj.signedIn)
      ..writeByte(5)
      ..write(obj.settings)
      ..writeByte(6)
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

class AccountTypeAdapter extends TypeAdapter<AccountType> {
  @override
  final int typeId = 11;

  @override
  AccountType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AccountType.anonymous;
      case 1:
        return AccountType.registered;
      default:
        return AccountType.anonymous;
    }
  }

  @override
  void write(BinaryWriter writer, AccountType obj) {
    switch (obj) {
      case AccountType.anonymous:
        writer.writeByte(0);
        break;
      case AccountType.registered:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SecurityLevelAdapter extends TypeAdapter<SecurityLevel> {
  @override
  final int typeId = 12;

  @override
  SecurityLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SecurityLevel.none;
      case 1:
        return SecurityLevel.pin;
      default:
        return SecurityLevel.none;
    }
  }

  @override
  void write(BinaryWriter writer, SecurityLevel obj) {
    switch (obj) {
      case SecurityLevel.none:
        writer.writeByte(0);
        break;
      case SecurityLevel.pin:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecurityLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountSettingsLocalAdapter extends TypeAdapter<AccountSettingsLocal> {
  @override
  final int typeId = 2;

  @override
  AccountSettingsLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountSettingsLocal(
      themeMode: fields[0] as ThemeModeLocal,
      languageCode: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountSettingsLocal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.themeMode)
      ..writeByte(1)
      ..write(obj.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountSettingsLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModeLocalAdapter extends TypeAdapter<ThemeModeLocal> {
  @override
  final int typeId = 22;

  @override
  ThemeModeLocal read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModeLocal.system;
      case 1:
        return ThemeModeLocal.light;
      case 2:
        return ThemeModeLocal.dark;
      default:
        return ThemeModeLocal.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModeLocal obj) {
    switch (obj) {
      case ThemeModeLocal.system:
        writer.writeByte(0);
        break;
      case ThemeModeLocal.light:
        writer.writeByte(1);
        break;
      case ThemeModeLocal.dark:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      themeMode: fields[0] as ThemeModes,
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

class ThemeModesAdapter extends TypeAdapter<ThemeModes> {
  @override
  final int typeId = 22;

  @override
  ThemeModes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModes.auto;
      case 1:
        return ThemeModes.light;
      case 2:
        return ThemeModes.dark;
      default:
        return ThemeModes.auto;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModes obj) {
    switch (obj) {
      case ThemeModes.auto:
        writer.writeByte(0);
        break;
      case ThemeModes.light:
        writer.writeByte(1);
        break;
      case ThemeModes.dark:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

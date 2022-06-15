import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'account_settings.g.dart';

class AccountSettings {
  final ThemeModes themeMode;
  final Locale locale;

  const AccountSettings._({
    required this.themeMode,
    required this.locale,
  });

  const AccountSettings.preset()
      : this._(themeMode: ThemeModes.dark, locale: const Locale('en'));

  const AccountSettings.builder({
    required ThemeModes themeMode,
    required Locale locale,
  }) : this._(themeMode: themeMode, locale: locale);

  AccountSettings copyFrom({
    ThemeModes? themeMode,
    Locale? locale,
  }) {
    return AccountSettings._(
        themeMode: themeMode ?? this.themeMode, locale: locale ?? this.locale);
  }
}

@HiveType(typeId: 22)
enum ThemeModes {
  @HiveField(0)
  auto,
  @HiveField(1)
  light,
  @HiveField(2)
  dark,
}

@HiveType(typeId: 2)
class AccountSettingsLocal {
  @HiveField(0)
  final ThemeModes themeMode;
  @HiveField(1)
  final String languageCode;

  const AccountSettingsLocal(
      {required this.themeMode, required this.languageCode});
}

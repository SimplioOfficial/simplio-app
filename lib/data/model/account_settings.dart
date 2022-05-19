import 'package:hive/hive.dart';

part 'account_settings.g.dart';

class AccountSettings {
  final ThemeModes themeMode;

  const AccountSettings._({
    required this.themeMode,
  });

  const AccountSettings.preset()
      : this._(
          themeMode: ThemeModes.auto,
        );

  const AccountSettings.builder({
    required ThemeModes themeMode,
  }) : this._(themeMode: themeMode);

  AccountSettings copyFrom({
    ThemeModes? themeMode,
  }) {
    return AccountSettings._(
      themeMode: themeMode ?? this.themeMode,
    );
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

  const AccountSettingsLocal({
    required this.themeMode,
  });
}

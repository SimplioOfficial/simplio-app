import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    as app_localizations;

// the class exist only for better package import because IDE cannot find the
// app_localizations package on it's own and developer would need to add it manually every time
class AppLocalizations {
  static app_localizations.AppLocalizations? of(BuildContext context) {
    return app_localizations.AppLocalizations.of(context);
  }

  static List<Locale> get supportedLocales =>
      app_localizations.AppLocalizations.supportedLocales;

  static List<String> get supportedLanguageCodes =>
      supportedLocales.map((e) => e.languageCode).toList();
}

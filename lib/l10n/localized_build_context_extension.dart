import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  List<String> get supportedLanguageCodes =>
      supportedLocales.map((e) => e.languageCode).toList();
}

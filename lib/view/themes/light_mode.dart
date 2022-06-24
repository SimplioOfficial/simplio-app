import 'package:flutter/material.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class LightMode {
  LightMode._();

  static ColorScheme get colorScheme => const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.blue,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.redAccent,
      background: Colors.orangeAccent,
      onBackground: Colors.orange,
      surface: Colors.brown,
      onSurface: Colors.blueAccent);

  static TextTheme get textTheme => TextTheme(
        displayLarge: TextStyle(color: colorScheme.onPrimary),
        displayMedium: TextStyle(color: colorScheme.onPrimary),
        displaySmall: TextStyle(color: colorScheme.onPrimary),
        headlineLarge: TextStyle(color: colorScheme.onPrimary),
        headlineMedium: TextStyle(color: colorScheme.onPrimary),
        headlineSmall: TextStyle(color: colorScheme.onPrimary),
        bodyLarge: TextStyle(color: colorScheme.onPrimary),
        bodyMedium: TextStyle(color: colorScheme.onPrimary),
        bodySmall: TextStyle(color: colorScheme.onPrimary),
        labelLarge: TextStyle(color: colorScheme.onPrimary),
        labelMedium: TextStyle(color: colorScheme.onPrimary),
        labelSmall: TextStyle(color: colorScheme.onPrimary),
        titleLarge: TextStyle(color: colorScheme.onPrimary),
        titleMedium: TextStyle(color: colorScheme.onPrimary),
        titleSmall: TextStyle(color: colorScheme.onPrimary),
      );

  static ThemeData theme = CommonTheme.theme.copyWith(
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      titleTextStyle: TextStyle(
        backgroundColor: colorScheme.primary,
        color: colorScheme.onPrimary,
      ),
    ),
  );
}

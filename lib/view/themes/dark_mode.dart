import 'package:flutter/material.dart';

import 'common_theme.dart';

class DarkMode {
  DarkMode._();

  static Color get backgroundColor => const Color.fromRGBO(41, 46, 50, 1);

  static Color get buttonColor => const Color.fromRGBO(58, 64, 69, 1);

  static Color get fontColor => Colors.white;

  static ColorScheme get colorScheme => ColorScheme(
        brightness: Brightness.dark,
        primary: backgroundColor,
        onPrimary: fontColor,
        secondary: const Color.fromRGBO(95, 151, 246, 1),
        onSecondary: fontColor,
        error: const Color.fromRGBO(232, 71, 61, 1),
        onError: Colors.redAccent,
        tertiary: const Color.fromRGBO(20, 193, 89, 1),
        background: Colors.orangeAccent,
        onBackground: Colors.orange,
        surface: Colors.brown,
        onSurface: Colors.blueAccent,
      );

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
    highlightColor: buttonColor,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      backgroundColor: colorScheme.primary,
      titleTextStyle: TextStyle(
        backgroundColor: colorScheme.primary,
        color: colorScheme.onPrimary,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: buttonColor,
      unselectedItemColor: fontColor,
      selectedItemColor: fontColor,
    ),
    inputDecorationTheme: CommonTheme.theme.inputDecorationTheme.copyWith(
      fillColor: colorScheme.onPrimary,
      labelStyle: TextStyle(color: colorScheme.primary),
      iconColor: colorScheme.primary,
      hintStyle: TextStyle(fontSize: 16.0, color: colorScheme.onPrimary),
      border: InputBorder.none,
      errorStyle: TextStyle(
        color: colorScheme.error,
        fontSize: 14,
      ),
    ),
    scaffoldBackgroundColor: backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: CommonTheme.theme.elevatedButtonTheme.style?.merge(
        ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) =>
              states.isNotEmpty && states.first == MaterialState.pressed
                  ? colorScheme.secondary
                  : buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: CommonTheme.buttonBorderRadius,
              // side: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}

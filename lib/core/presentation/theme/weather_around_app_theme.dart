import 'package:flutter/material.dart';

class WeatherAroundAppTheme {
  static ThemeData get themeData {
    ColorScheme colorScheme = ColorScheme.light(
      primary: Colors.blueGrey.withGreen(100),
      background: Colors.blueGrey.withGreen(100),
      onPrimary: Colors.white,
      onBackground: Colors.white,
    );

    final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      border: const UnderlineInputBorder(),
      prefixIconColor: colorScheme.onPrimary,
      focusColor: colorScheme.onPrimary,
      hintStyle: TextStyle(
        color: colorScheme.onPrimary,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.onPrimary),
      ),
      iconColor: colorScheme.onBackground,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
      ),
    );

    return ThemeData.from(colorScheme: colorScheme).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white.withOpacity(0.3),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: inputDecorationTheme,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

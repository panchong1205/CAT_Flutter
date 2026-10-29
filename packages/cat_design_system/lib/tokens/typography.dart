import 'package:flutter/material.dart';

class CatTypography {
  CatTypography._();

  // -- Font sizes --
  static const double caption = 12.0;
  static const double body = 14.0;
  static const double bodyLarge = 16.0;
  static const double subtitle = 18.0;
  static const double title = 20.0;
  static const double headline = 24.0;
  static const double display = 32.0;

  // -- Vehicle typography (dark, large screens) --
  static TextTheme vehicleTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, letterSpacing: -1),
    headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  );

  // -- Tablet typography (standard size) --
  static TextTheme tabletTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
  );

  // -- Phone typography (compact) --
  static TextTheme phoneTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
  );
}
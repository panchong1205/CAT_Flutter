import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CatThemes {
  CatThemes._();

  static ThemeData get vehicleTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: CatColors.vehiclePrimary,
        onPrimary: CatColors.vehicleOnBg,
        secondary: CatColors.vehicleSecondary,
        onSecondary: CatColors.vehicleOnBg,
        error: CatColors.vehicleError,
        onError: Colors.white,
        surface: CatColors.vehicleSurface,
        onSurface: CatColors.vehicleOnSurface,
        surfaceDim: CatColors.vehicleBg,
        surfaceContainerHighest: CatColors.vehicleSurfaceVariant,
        outline: CatColors.vehicleBorder,
        outlineVariant: CatColors.vehicleDivider,
      ),
      scaffoldBackgroundColor: CatColors.vehicleBg,
      dividerColor: CatColors.vehicleBorder,
      dividerTheme: const DividerThemeData(
        color: CatColors.vehicleBorder,
        thickness: 1,
        space: 0,
      ),
      textTheme: CatTypography.vehicleTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: CatColors.vehicleSurface,
        foregroundColor: CatColors.vehicleOnBg,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        color: CatColors.vehicleSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CatColors.vehicleBorder),
        ),
        margin: const EdgeInsets.all(0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CatColors.vehicleSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.vehicleBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.vehicleBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.vehiclePrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CatColors.vehicleSurface,
        indicatorColor: CatColors.vehiclePrimary.withAlpha(30),
        elevation: 1,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: CatColors.vehicleSurface,
        selectedIconTheme: const IconThemeData(color: CatColors.vehiclePrimary),
        unselectedIconTheme: const IconThemeData(color: CatColors.vehicleOnSurface),
      ),
    );
  }

  static ThemeData get tabletTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: CatColors.tabletPrimary,
        onPrimary: Colors.white,
        secondary: CatColors.tabletSecondary,
        onSecondary: Colors.white,
        error: CatColors.tabletError,
        onError: Colors.white,
        surface: CatColors.tabletSurface,
        onSurface: CatColors.tabletOnBg,
        surfaceDim: CatColors.tabletBg,
        surfaceContainerHighest: CatColors.tabletSurfaceVariant,
        outline: CatColors.tabletBorder,
        outlineVariant: CatColors.tabletDivider,
      ),
      scaffoldBackgroundColor: CatColors.tabletBg,
      dividerColor: CatColors.tabletBorder,
      dividerTheme: const DividerThemeData(
        color: CatColors.tabletBorder,
        thickness: 1,
        space: 0,
      ),
      textTheme: CatTypography.tabletTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: CatColors.tabletSurface,
        foregroundColor: CatColors.tabletOnBg,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        color: CatColors.tabletSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CatColors.tabletBorder),
        ),
        margin: const EdgeInsets.all(0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CatColors.tabletSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.tabletBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.tabletBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.tabletPrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CatColors.tabletSurface,
        indicatorColor: CatColors.tabletPrimary.withAlpha(20),
        elevation: 1,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: CatColors.tabletSurface,
        indicatorColor: CatColors.tabletPrimary.withAlpha(40),
        selectedIconTheme: const IconThemeData(color: CatColors.tabletPrimary),
        unselectedIconTheme: const IconThemeData(color: CatColors.tabletOnSurface),
        selectedLabelTextStyle: const TextStyle(color: CatColors.tabletPrimary, fontSize: 12),
        unselectedLabelTextStyle: const TextStyle(color: CatColors.tabletOnSurface, fontSize: 12),
      ),
    );
  }

  static ThemeData get phoneTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: CatColors.phonePrimary,
        onPrimary: Colors.white,
        secondary: CatColors.phoneSecondary,
        onSecondary: Colors.white,
        error: CatColors.phoneError,
        onError: Colors.white,
        surface: CatColors.phoneSurface,
        onSurface: CatColors.phoneOnBg,
        surfaceDim: CatColors.phoneBg,
        surfaceContainerHighest: CatColors.phoneSurfaceVariant,
        outline: CatColors.phoneBorder,
        outlineVariant: CatColors.phoneDivider,
      ),
      scaffoldBackgroundColor: CatColors.phoneBg,
      dividerColor: CatColors.phoneBorder,
      dividerTheme: const DividerThemeData(
        color: CatColors.phoneBorder,
        thickness: 0.5,
        space: 0,
      ),
      textTheme: CatTypography.phoneTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: CatColors.phoneSurface,
        foregroundColor: CatColors.phoneOnBg,
        elevation: 0,
        scrolledUnderElevation: 0.5,
      ),
      cardTheme: CardThemeData(
        color: CatColors.phoneSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: CatColors.phoneBorder),
        ),
        margin: const EdgeInsets.all(0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CatColors.phoneSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.phoneBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.phoneBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatColors.phonePrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CatColors.phoneSurface,
        indicatorColor: CatColors.phonePrimary.withAlpha(15),
        elevation: 1,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: CatColors.phoneSurface,
        selectedIconTheme: const IconThemeData(color: CatColors.phonePrimary),
        unselectedIconTheme: const IconThemeData(color: CatColors.phoneOnSurface),
      ),
    );
  }
}
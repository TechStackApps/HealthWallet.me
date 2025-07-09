import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Matter',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.background,
      secondary: AppColors.secondary,
      onSecondary: AppColors.background,
      error: AppColors.error,
      onError: AppColors.background,
      surface: AppColors.surface, // Card background
      onSurface: AppColors.textPrimary,
    ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Matter',
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(
          color: AppColors.border,
          width: 1.0,
        ),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
    dividerColor: AppColors.border,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.textPrimary,
    fontFamily: 'Matter',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.background,
      secondary: AppColors.secondary,
      onSecondary: AppColors.background,
      error: AppColors.error,
      onError: AppColors.background,
      surface: AppColors.textPrimary, // Card background
      onSurface: AppColors.background,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Matter',
          bodyColor: AppColors.background,
          displayColor: AppColors.background,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.textPrimary,
      foregroundColor: AppColors.background,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: AppColors.border, width: 1.0),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
    dividerColor: AppColors.border,
  );
}

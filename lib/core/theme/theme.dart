import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_wallet/core/theme/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.fastenLightGray100,
    colorScheme: const ColorScheme.light(
      primary: AppColors.fastenLightPrimaryColor,
      onPrimary: AppColors.backgroundWhite,
      secondary: AppColors.fastenLightBlue,
      onSecondary: AppColors.backgroundWhite,
      error: AppColors.fastenLightRed,
      onError: AppColors.backgroundWhite,
      surface: AppColors.backgroundWhite, // Card background
      onSurface: AppColors.fastenLightBodyColor,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme.apply(
        bodyColor: AppColors.fastenLightBodyColor,
        displayColor: AppColors.fastenLightGray900,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundWhite,
      foregroundColor: AppColors.fastenLightGray900,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.backgroundWhite,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(
          color: AppColors.fastenLightBorderBase,
          width: 1.0,
        ),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
    dividerColor: AppColors.fastenLightBorderBase,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.fastenDarkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.fastenDarkPrimary,
      onPrimary: AppColors.fastenDarkTextWhiteColor,
      secondary: AppColors.fastenDarkLinkColor,
      onSecondary: AppColors.fastenDarkTextWhiteColor,
      error: Colors.redAccent, // Keep Flutter default for now
      onError: AppColors.fastenDarkTextWhiteColor,
      surface: AppColors.fastenDarkCard, // Card background
      onSurface: AppColors.fastenDarkTextColor,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme.apply(
        bodyColor: AppColors.fastenDarkTextColor,
        displayColor: AppColors.fastenDarkCardForeground,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.fastenDarkHeader,
      foregroundColor: AppColors.fastenDarkTextWhiteColor,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.fastenDarkCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: AppColors.fastenDarkBorder, width: 1.0),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
    dividerColor: AppColors.fastenDarkBorder,
  );
}

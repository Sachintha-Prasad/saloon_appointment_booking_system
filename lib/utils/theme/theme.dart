import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:saloon_appointment_booking_system/utils/theme/custom_themes/progress_indicator_theme.dart';
import 'package:saloon_appointment_booking_system/utils/theme/custom_themes/text_selection_theme.dart';
import 'package:saloon_appointment_booking_system/utils/theme/custom_themes/text_theme.dart';

class SBAppTheme {
  SBAppTheme._();

// light theme
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: SBColors.primary,
      scaffoldBackgroundColor: SBColors.bgLight,
      appBarTheme: SBAppBarTheme.appBarThemeLight,
      textTheme: SBTextTheme.lightTextTheme,
      textSelectionTheme: SBTextSelectionTheme.textSelectionThemeData,
      progressIndicatorTheme: SBProgressIndicatorTheme.progressIndicatorThemeData
  );


// dark theme
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: SBColors.primary,
      scaffoldBackgroundColor: SBColors.bgDark,
      appBarTheme: SBAppBarTheme.appBarThemeDark,
      textTheme: SBTextTheme.darkTextTheme,
      textSelectionTheme: SBTextSelectionTheme.textSelectionThemeData,
      progressIndicatorTheme: SBProgressIndicatorTheme.progressIndicatorThemeData
  );
}

import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';

class SBAppBarTheme {
  SBAppBarTheme._();

  // app bar light theme
  static const AppBarTheme appBarThemeLight = AppBarTheme(
    backgroundColor: SBColors.bgLight,
  );

  // app bar dark theme
  static const AppBarTheme appBarThemeDark = AppBarTheme(
      backgroundColor: SBColors.bgDark
  );
}
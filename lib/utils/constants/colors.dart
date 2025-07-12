import 'package:flutter/material.dart';

class SBColors {
  SBColors._();

  // primary colors
  static const Color primary = Color(0xFF0083ac);
  static const Color red = Color(0xFFED4C5C);
  static const Color green = Color(0xFF089d37);

  // neutral colors
  static const Color white = Colors.white;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color(0xFF757575);

  // bg colors
  static const Color bgLight = Colors.white;
  static const Color bgDark = Color(0xFF111111);

  // text colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF757575);

  // button colors
  static const Color primaryButton = Color(0xFF0083ac);
  static const Color secondaryButton = Color(0xFFBDBDBD);
  static const Color borderedButton = Colors.transparent;
  static const Color dangerButton = Color(0xFFB00020);
  static const Color transparentButton = Color.fromARGB(255, 6, 72, 90);

  // input field colors
  static const Color inputFieldBgLight = Color.fromRGBO(240, 243, 246, 0);
  static const Color inputFieldBgDark = Color(0xFF212121);
  static const Color inputPlaceholderLight = Color(0xFFBDBDBD);
  static const Color inputPlaceholderDark = Color(0xFF757575);

  // success colors
  static const Color successColor = Color(0xFF089d37);

  // error colors
  static const Color errorColor = Color(0xFFB00020);

  // Dark mode colors for time slots
  static const Color darkModeInactiveSlotBgColor =
      Color.fromARGB(255, 218, 234, 239);
  static const Color darkModeInactiveSlotTextColor =
      Color.fromARGB(255, 176, 176, 176);
  static const Color darkModeBorderColor = Color(0xFF404040);
}

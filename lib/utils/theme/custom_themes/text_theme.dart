import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class SBTextTheme {
  SBTextTheme._();

  // google font function =================================================================================
  // function to generate manrope texts
  static TextStyle manropeText(
      {double size = 24,
      FontWeight weight = FontWeight.w600,
      Color color = Colors.black}) {
    return GoogleFonts.manrope(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  // function to generate nunito texts
  static TextStyle nunitoText(
      {double size = 16,
      FontWeight weight = FontWeight.w400,
      Color color = Colors.black}) {
    return GoogleFonts.nunitoSans(
        fontSize: size, fontWeight: weight, color: color);
  }

  // theme wise text ======================================================================================
  // light text theme
  static TextTheme lightTextTheme = TextTheme(
    // header
    headlineLarge: manropeText(
        size: SBSizes.fontSizeXl,
        color: SBColors.textPrimaryLight,
        weight: FontWeight.w600),
    headlineMedium: manropeText(
        size: SBSizes.fontSizeLg,
        color: SBColors.textPrimaryLight,
        weight: FontWeight.w600),
    headlineSmall: manropeText(
        size: SBSizes.fontSizeMd,
        color: SBColors.textPrimaryLight,
        weight: FontWeight.w600),

    // body
    bodyLarge:
        nunitoText(size: SBSizes.fontSizeMd, color: SBColors.textPrimaryLight),
    bodyMedium:
        nunitoText(size: SBSizes.fontSizeSm, color: SBColors.textPrimaryLight),
    bodySmall:
        nunitoText(size: SBSizes.fontSizeXs, color: SBColors.textPrimaryLight),
  );

  // dark text theme
  static TextTheme darkTextTheme = TextTheme(
    // header
    headlineLarge: manropeText(
        size: SBSizes.fontSizeXl,
        color: SBColors.textPrimaryDark,
        weight: FontWeight.w600),
    headlineMedium: manropeText(
        size: SBSizes.fontSizeLg,
        color: SBColors.textPrimaryDark,
        weight: FontWeight.w600),
    headlineSmall: manropeText(
        size: SBSizes.fontSizeMd,
        color: SBColors.textPrimaryDark,
        weight: FontWeight.w600),

    // body
    bodyLarge:
        nunitoText(size: SBSizes.fontSizeMd, color: SBColors.textPrimaryDark),
    bodyMedium:
        nunitoText(size: SBSizes.fontSizeSm, color: SBColors.textPrimaryDark),
    bodySmall:
        nunitoText(size: SBSizes.fontSizeXs, color: SBColors.textPrimaryDark),
  );
}

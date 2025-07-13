import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';

class SBHelperFunctions {
  SBHelperFunctions._();

  // function to check is dark mode==========================================================================================================
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // function to get first name==============================================================================================================
  static String? getFirstName(String fullName) {
    if (fullName.isEmpty) return "";

    // split the full name by spaces and return the first part
    List<String> nameParts = fullName.split(' ');

    return nameParts[0].capitalize!;
  }

  // function to convert date into YYYY-MM-DD format=========================================================================================
  static String convertDate(DateTime date) {
    return date.toIso8601String().split("T")[0];
  }

  // function to get avatar characters when there is no profile img==========================================================================
  static String getAvatarLetters(String name) {
    if (name.isEmpty) return "NA";

    // split the name by spaces
    List<String> nameParts = name.split(' ');

    // get the first letter of the first name
    String firstLetter =
        nameParts[0].isNotEmpty ? nameParts[0][0].toUpperCase() : "";

    // get the first letter of the last name (if it exists)
    String lastLetter = nameParts.length > 1 && nameParts[1].isNotEmpty
        ? nameParts[1][0].toUpperCase()
        : "";

    // combine both letters
    return firstLetter + lastLetter;
  }

  // function to capitalize strings======================================================================================================
  static String capitalizeString(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // snackbars===========================================================================================================================
  // show normal snackbar
  static Future<void>? showSnackbar(String message) {
    Get.snackbar(
      "Info",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SBColors.darkGrey.withOpacity(0.5),
      colorText: SBColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.info, color: SBColors.white),
      duration: const Duration(seconds: 3),
    );
    return null;
  }

  // show success snackbar
  static Future<void>? showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SBColors.darkGrey.withOpacity(0.5),
      colorText: SBColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check_circle, color: SBColors.successColor),
      duration: const Duration(seconds: 3),
    );
    return null;
  }

  // show error snackbar
  static Future<void>? showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SBColors.darkGrey.withOpacity(0.5),
      colorText: SBColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.error, color: SBColors.red),
      duration: const Duration(seconds: 3),
    );
    return null;
  }

  // show dark snackbar
  static Future<void>? showDarkSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SBColors.transparentButton,
      colorText: SBColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check_circle, color: SBColors.white),
      duration: const Duration(seconds: 3),
    );
    return null;
  }
}

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

  // function to get avatar characters when there is no profile img==========================================================================
  static String getAvatarLetters(String name) {
    if (name.isEmpty) return "NA";

    // split the name by spaces
    List<String> nameParts = name.split(' ');

    // get the first letter of the first name
    String firstLetter = nameParts[0].isNotEmpty ? nameParts[0][0].toUpperCase() : "";

    // get the first letter of the last name (if it exists)
    String lastLetter = nameParts.length > 1 && nameParts[1].isNotEmpty ? nameParts[1][0].toUpperCase() : "";

    // combine both letters
    return firstLetter + lastLetter;
  }

  // snackbars===========================================================================================================================
  // show normal snackbar
  static Future<void>? showSnackbar(String message) {
    Get.snackbar(
      "Info",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
    return null;
  }

  // show success snackbar
  static Future<void>? showSuccessSnackbar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SBColors.successColor.withOpacity(0.1),
      colorText: SBColors.successColor,
    );
    return null;
  }

  // show error snackbar
  static Future<void>? showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: SBColors.errorColor.withOpacity(0.1),
      colorText: SBColors.errorColor,
    );
    return null;
  }
}

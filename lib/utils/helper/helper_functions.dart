import 'package:flutter/material.dart';

class SBHelperFunctions {
  SBHelperFunctions._();

  // function to check is dark mode==========================================================================================================
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

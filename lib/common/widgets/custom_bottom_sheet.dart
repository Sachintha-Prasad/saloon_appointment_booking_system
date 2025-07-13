import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final bool isScrollControlled;

  const CustomBottomSheet({
    Key? key,
    required this.child,
    this.isScrollControlled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = SBHelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF1E1E1E)
            : SBColors
                .darkModeInactiveSlotBgColor, // Consistent with your reference
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey[600]
                    : Colors.grey[400], // Lighter handle bar for light mode
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // User content
          child,

          // Bottom safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  /// Show the custom bottom sheet
  static Future<T?> show<T>({
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: Get.context!,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomBottomSheet(
        child: child,
        isScrollControlled: isScrollControlled,
      ),
    );
  }

  /// Close any open bottom sheet (just pops the route)
  static void close<T extends Object?>([T? result]) {
    if (Navigator.of(Get.context!).canPop()) {
      Navigator.of(Get.context!).pop(result);
    }
  }
}

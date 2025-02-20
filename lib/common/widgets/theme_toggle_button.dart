import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import '../../controllers/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
   const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Padding(
      padding: const EdgeInsets.only(right: SBSizes.md),
      child: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return RotationTransition(turns: animation, child: child);
        },
        child: IconButton(
          key: ValueKey<bool>(themeController.isDarkMode.value),
          onPressed: () => themeController.toggleTheme(),
          icon: themeController.isDarkMode.value
              ? const Icon(Icons.light_mode_outlined, size: SBSizes.iconMd)
              : const Icon(Icons.dark_mode_outlined, size: SBSizes.iconMd),
        ),
      )),
    );
  }
}
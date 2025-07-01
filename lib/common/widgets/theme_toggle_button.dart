import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
   const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: animation,
          child: child,
        ),
        child: themeController.themeMode.value == ThemeMode.dark
            ? const Icon(Icons.light_mode_outlined, key: ValueKey('light'))
            : const Icon(Icons.dark_mode_outlined, key: ValueKey('dark')),
      ),
      onPressed: themeController.toggleTheme,
    ));
  }
}
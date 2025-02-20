import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  RxBool isDarkMode = false.obs;

  Future<void> loadThemeFromStorage() async {
    String? savedTheme = await StorageService.getTheme();

    if (savedTheme == null) {
      const ThemeMode themeMode = ThemeMode.system;
      isDarkMode.value = themeMode == ThemeMode.dark;
    } else {
      isDarkMode.value = savedTheme == 'dark';
    }

    update(); // Notify UI to rebuild
  }

  // handle theme toggle
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    StorageService.setTheme(isDarkMode.value ? "dark" : "light" );
  }
}
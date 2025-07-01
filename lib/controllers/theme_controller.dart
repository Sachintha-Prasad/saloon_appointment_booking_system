import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage _storage = GetStorage();
  final String _themeKey = 'themeMode';

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromStorage();
  }

  void _saveThemeToStorage(String theme) {
    _storage.write(_themeKey, theme);
  }

  void loadThemeFromStorage() {
    String? savedTheme = _storage.read(_themeKey);

    if (savedTheme == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else if (savedTheme == 'light') {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.system;
    }

    Get.changeThemeMode(themeMode.value);
  }

  // handle theme toggle
  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
      _saveThemeToStorage('light');
    } else {
      themeMode.value = ThemeMode.dark;
      _saveThemeToStorage('dark');
    }

    Get.changeThemeMode(themeMode.value);
  }
}
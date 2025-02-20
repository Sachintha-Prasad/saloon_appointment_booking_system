import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/theme_controller.dart';
import 'package:saloon_appointment_booking_system/screens/splash/splash_screen.dart';
import 'package:saloon_appointment_booking_system/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  // initialize the user
  Get.put(AuthController());

  // initialize the theme
  final ThemeController themeController = Get.put(ThemeController());
  await themeController.loadThemeFromStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          // theme modes
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: SBAppTheme.lightTheme,
          darkTheme: SBAppTheme.darkTheme,

          // transitions
          defaultTransition: Transition.rightToLeftWithFade,
          transitionDuration: const Duration(milliseconds: 200),

          // routes
          home: const SplashScreen(),
        );
      }
    );
  }
}

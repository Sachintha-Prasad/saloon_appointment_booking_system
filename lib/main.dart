import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saloon_appointment_booking_system/bindings/app_binding.dart';
import 'package:saloon_appointment_booking_system/controllers/theme_controller.dart';
import 'package:saloon_appointment_booking_system/screens/splash/splash_screen.dart';
import 'package:saloon_appointment_booking_system/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  // initialize the getX storage
  await GetStorage.init();

  // initialize the theme
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      final ThemeController themeController = Get.find<ThemeController>();

      return Obx(() => GetMaterialApp(
        debugShowCheckedModeBanner: false,

        // theme modes
        themeMode: themeController.themeMode.value,
        theme: SBAppTheme.lightTheme,
        darkTheme: SBAppTheme.darkTheme,

        // transitions
        defaultTransition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 200),

        // routes
        home: const SplashScreen(),
        initialBinding: AppBinding(),
      )
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/screens/splash/splash_screen.dart';
import 'firebase/firebase_options.dart';
import 'package:saloon_appointment_booking_system/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,)
      .then((value) => Get.put(AuthRepository()));
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // theme modes
      themeMode: ThemeMode.system,
      theme: SBAppTheme.lightTheme,
      darkTheme: SBAppTheme.darkTheme,

      // transitions
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),

      // routes
      home: const SplashScreen(),
    );
  }
}

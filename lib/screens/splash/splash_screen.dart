import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _authController.autoLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SBColors.primary,
      body: Center(
        child: Lottie.asset(
          SBImages.splashAnimation,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

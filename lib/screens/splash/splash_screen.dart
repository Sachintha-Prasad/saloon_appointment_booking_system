import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saloon_appointment_booking_system/screens/auth/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Center(
        child: Lottie.asset(
          SBImages.splashAnimation,
          fit: BoxFit.cover,
        ),
      ),
      nextScreen: const OnboardingScreen(),
      splashIconSize: double.infinity,
      backgroundColor: SBColors.primary,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

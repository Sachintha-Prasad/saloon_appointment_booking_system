import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saloon_appointment_booking_system/features/home/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Center(
        child: Lottie.asset(
          'assets/animations/splash_animation.json',
          fit: BoxFit.cover,
        ),
      ),
      nextScreen: const HomePage(),
      splashIconSize: double.infinity,
      backgroundColor: const Color(0xFF0083ac),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

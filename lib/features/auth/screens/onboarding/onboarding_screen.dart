import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saloon_appointment_booking_system/features/auth/lib/onboarding_data.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/login/login_screen.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/onboarding/onboarding_page.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/welcome/welcome_screen.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  // Navigate to Register Screen
  void _navigateToWelcome() {
    Get.to(const WelcomeScreen());
  }

  // Navigate to Login Screen
  void _navigateToLogin() {
    Get.to(const LogInScreen());
  }

  // Handle next button press
  void _onNextPressed() {
    if (currentIndex < OnboardingData.data.length - 1) {
      setState(() {
        currentIndex++;
      });
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToWelcome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: OnboardingData.data.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final page = OnboardingData.data[index];
                return OnboardingPage(
                  img: page["img"]!,
                  title: page["title"]!,
                  subtitle: page["subtitle"]!,
                  buttonText: page["buttonText"]!,
                  onButtonPressed: _onNextPressed,
                  onLoginPressed: _navigateToLogin,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

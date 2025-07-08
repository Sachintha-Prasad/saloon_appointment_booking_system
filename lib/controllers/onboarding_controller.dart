import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/data/auth/onboarding_data.dart';
import 'package:saloon_appointment_booking_system/screens/auth/login/login_screen.dart';
import 'package:saloon_appointment_booking_system/screens/auth/register/register_screen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();

  final RxInt currentIndex = 0.obs;

  // navigate to Register Screen
  void navigateToRegister() {
    Get.to(const RegisterScreen());
  }

  // navigate to Login Screen
  void navigateToLogin() {
    Get.to(const LogInScreen());
  }

  // handle Next Button Press
  void onNextPressed() {
    if (currentIndex.value < OnboardingData.data.length - 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToRegister();
    }
  }
}

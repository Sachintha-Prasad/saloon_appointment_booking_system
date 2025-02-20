import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/onboarding_controller.dart';
import 'package:saloon_appointment_booking_system/data/auth/onboarding_data.dart';
import 'package:saloon_appointment_booking_system/screens/auth/onboarding/widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<OnboardingController>(
              builder: (controller) {
                return PageView.builder(
                  controller: controller.pageController,
                  itemCount: OnboardingData.data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final page = OnboardingData.data[index];
                    return OnboardingPage(
                      img: page["img"]!,
                      title: page["title"]!,
                      subtitle: page["subtitle"]!,
                      buttonText: page["buttonText"]!,
                      onButtonPressed: controller.onNextPressed,
                      onLoginPressed: controller.navigateToLogin,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

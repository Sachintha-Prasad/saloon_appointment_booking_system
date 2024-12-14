import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final data = [
    {"img": '../assets/images/onboarding_img_1'},
    {"img": '../assets/images/onboarding_img_2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

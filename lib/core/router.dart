import 'package:flutter/material.dart';
import 'constants.dart';
import '../features/home/home_page.dart';
import '../features/splash/splash_screen.dart';
import '../features/onbording/onboarding_screen.dart';
import '../features/not_found/not_found_screen.dart';

// generate router function
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}

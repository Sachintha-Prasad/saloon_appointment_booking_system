import 'package:saloon_appointment_booking_system/screens/auth/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/screens/admin/admin_dashboard.dart';
import 'package:saloon_appointment_booking_system/screens/client/client_dashboard.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/stylist_dashboard.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:get/get.dart';

class SBRedirectToDashboard {
  SBRedirectToDashboard._();

  static Roles getRoleFromString(String role) {
    switch (role) {
      case 'CLIENT':
        return Roles.client;
      case 'STYLIST':
        return Roles.stylist;
      case 'ADMIN':
        return Roles.admin;
      default:
        throw Exception("Unknown role: $role");
    }
  }

  static void getDashboardBasedOnRole(Roles role) {
    // Navigate based on the role
    if (role == Roles.client) {
      Get.offAll(() => const ClientDashboard());
    } else if (role == Roles.stylist) {
      Get.offAll(() => const StylistDashboard());
    } else if (role == Roles.admin) {
      Get.offAll(() => const AdminDashboard());
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }
}

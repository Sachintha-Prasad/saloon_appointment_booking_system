import 'package:saloon_appointment_booking_system/screens/auth/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/screens/admin/admin_dashboard.dart';
import 'package:saloon_appointment_booking_system/screens/client/client_dashboard.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/stylist_dashboard.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';

class SBRedirectToDashboard {
  SBRedirectToDashboard._();

  static Roles getRoleFromString(String role) {
    switch (role) {
      case 'client':
        return Roles.CLIENT;
      case 'stylist':
        return Roles.STYLIST;
      case 'admin':
        return Roles.ADMIN;
      default:
        throw Exception("Unknown role: $role");
    }
  }

  static getDashboardBasedOnRole(Roles role) {
    if (role == Roles.CLIENT) {
      return const ClientDashboard();
    } else if (role == Roles.STYLIST) {
      return const StylistDashboard();
    } else if (role == Roles.ADMIN) {
      return const AdminDashboard();
    } else {
      return const OnboardingScreen();
    }
  }
}
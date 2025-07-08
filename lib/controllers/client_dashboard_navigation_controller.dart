import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/client_appointment_screen.dart';
import 'package:saloon_appointment_booking_system/screens/client/contact/client_contact_screen.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/client_home_screen.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/profile/client_profile_screen.dart';

class ClientDashboardNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    const ClientHomeScreen(),
    const ClientAppointmentScreen(),
    const ClientContactScreen(),
    const ClientProfileScreen(),
  ];
}
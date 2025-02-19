import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/screens/client/contact/client_contact.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/client_home.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/profile/client_profile_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';

class ClientDashboardNavigationController extends GetxController {
  static ClientDashboardNavigationController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;

  final screens = [
    const ClientHome(),
    Container(color: SBColors.green),
    const ClientContact(),
    const ClientProfileScreen(),
  ];
}
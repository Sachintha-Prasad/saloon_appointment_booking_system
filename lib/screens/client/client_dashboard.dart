import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/client_dashboard_navigation_controller.dart';
import 'package:saloon_appointment_booking_system/screens/client/navbar/client_nav_item.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';


class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final ClientDashboardNavigationController navigationController = Get.put(ClientDashboardNavigationController());

    return Scaffold(
      // navbar======================================================================================================
      bottomNavigationBar:
        Container(
            padding: const EdgeInsets.symmetric(vertical: SBSizes.md),
            color: SBColors.darkGrey.withOpacity(0.1),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClientNavItem(icon: Icons.home_filled, index: 0),
                ClientNavItem(icon: Icons.calendar_month, index: 1),
                ClientNavItem(icon: Icons.phone, index: 2),
                ClientNavItem(icon: Icons.person, index: 3),
              ],
            ),
        ),

      // render screens when change the indexes=====================================================================
      body: Obx(() => navigationController.screens[navigationController.selectedIndex.value]),
    );
  }
}





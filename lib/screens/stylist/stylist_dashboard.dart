import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class StylistDashboard extends StatelessWidget {
  const StylistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final userData = authController.currentUser.value;

      if (userData == null) {
        return const Scaffold(
          body: Center(
            child: Text('No user data found.'),
          ),
        );
      }

      return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: SBSpacingStyle.paddingMainLayout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Stylist ${SBHelperFunctions.getFirstName(userData.name)},",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find the service you want, and treat yourself',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              )),
        ),
      );
    });
  }
}

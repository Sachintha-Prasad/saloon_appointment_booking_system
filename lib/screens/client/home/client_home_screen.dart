import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/widgets/client_services.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/widgets/client_dashboard_carousel.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

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
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SBSizes.sm),
            child: Row(
              children: [
                Text(
                  "Hello, ",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  "${SBHelperFunctions.getFirstName(userData!.name)}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: SBColors.primary),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: SBSizes.md),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  color: SBColors.primary.withOpacity(0.1),
                ),
                child: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.notifications_none_outlined, color: SBColors.primary),
                ),
              )
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: SBSpacingStyle.paddingMainLayout,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book now for a timeless yet trendy experience!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: SBSizes.defaultSpace),

                // carousel====================================================================================
                const ClientDashboardCarousel(),
                const SizedBox(height: SBSizes.spaceBtwSections),

                // our services================================================================================
                const ClientServices(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

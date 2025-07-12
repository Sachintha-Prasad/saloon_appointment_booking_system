import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/profile_image.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/screens/profile/profile/user_profile_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // user profile image
                      ProfileImage(userData: userData),
                      const SizedBox(width: SBSizes.sm),

                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SBHelperFunctions.capitalizeString(userData.name),
                              style: Theme.of(context).textTheme.headlineMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Stylist',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: SBColors.darkGrey),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(UserProfileScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: SBColors.primary,
                                ),
                                child: Text(
                                  'Profile',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: SBColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24), // Spacing after the first row

                  // --- Second Row Placeholder ---
                  // Add your content for the second row here
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: SBColors.lightGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Second Row Content Area',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing after the second row

                  // --- Third Row Placeholder ---
                  // Add your content for the third row here
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: SBColors.lightGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Third Row Content Area',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}

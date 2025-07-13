import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/appointment_request_stat_card.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/stylist_dashboard_header.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/today_appointment_stat_card.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/upcoming_appointments_stat_card.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class StylistDashboard extends StatelessWidget {
  const StylistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final StylistController stylistController = Get.put(StylistController());

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
                  StylistDashboardHeader(userData: userData),
                  const SizedBox(height: SBSizes.spaceBtwSections),

                  TodayAppointmentsStatCard(stylistController: stylistController),
                  const SizedBox(height: SBSizes.md),

                  Row(
                    children: [
                      Expanded(
                        child: AppointmentRequestsStatCard(stylistController: stylistController),
                      ),
                      const SizedBox(width: SBSizes.md),
                      Expanded(
                        child: UpcomingAppointmentsStatCard(stylistController: stylistController),
                      ),
                    ],
                  ),
                  const SizedBox(height: SBSizes.spaceBtwSections),

                  Center(
                    child: CustomTextButton(
                      btnText: "Request a Leave",
                      prefixIcon: const Icon(Icons.airplane_ticket_outlined, size: 20, color: SBColors.white),
                      btnType: ButtonType.primary,
                      onPressed: () {
                        // TODO: Implement leave request logic or navigation
                        Get.snackbar("Leave Request", "Feature coming soon!");
                      },
                    ),
                  ),

                ],
              )),
        ),
      );
    });
  }
}



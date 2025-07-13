import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_bottom_sheet.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/appointment_request_stat_card.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/leave_request_bottom_sheet_content.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/stylist_dashboard_header.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/today_appointment_stat_card.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/widgets/upcoming_appointments_stat_card.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class StylistDashboard extends StatelessWidget {
  const StylistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final stylistController = Get.put(StylistController());

    return Obx(() {
      if (authController.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final userData = authController.currentUser.value;
      if (userData == null) {
        return const Scaffold(body: Center(child: Text('No user data found.')));
      }

      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: SBSpacingStyle.paddingMainLayout,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StylistDashboardHeader(userData: userData),
                  const SizedBox(height: SBSizes.spaceBtwSections),

                  TodayAppointmentsStatCard(stylistController: stylistController),
                  const SizedBox(height: SBSizes.md),

                  Row(
                    children: [
                      Expanded(child: AppointmentRequestsStatCard(stylistController: stylistController)),
                      const SizedBox(width: SBSizes.md),
                      Expanded(child: UpcomingAppointmentsStatCard(stylistController: stylistController)),
                    ],
                  ),
                  const SizedBox(height: SBSizes.spaceBtwSections),

                  CustomTextButton(
                    btnText: "Request Leave",
                    prefixIcon: const Icon(Icons.flight_takeoff),
                    onPressed: () {
                      CustomBottomSheet.show(
                        child: LeaveRequestBottomSheetContent(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

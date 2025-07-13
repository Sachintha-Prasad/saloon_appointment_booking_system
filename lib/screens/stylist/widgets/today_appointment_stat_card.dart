import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/today/today_appointments_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class TodayAppointmentsStatCard extends StatelessWidget {
  const TodayAppointmentsStatCard({
    super.key,
    required this.stylistController,
  });

  final StylistController stylistController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = SBHelperFunctions.isDarkMode(context);

    return Material(
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Get.to(() => const TodayAppointmentsScreen());
        },
        child: Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDarkMode
                  ? Colors.grey[700]!
                  : const Color.fromARGB(42, 0, 132, 172),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: SBColors.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 32,
                  color: SBColors.primary,
                ),
              ),
              const SizedBox(height: SBSizes.sm),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Today Appointments',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      final count =
                          stylistController.todaysAppointmentsCount.value;
                      return Text(
                        '$count',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

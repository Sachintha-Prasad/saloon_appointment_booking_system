import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/common/stylist_appointment_card.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class TodayAppointmentsScreen extends StatelessWidget {
  const TodayAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stylistController = Get.find<StylistController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Today's Appointments",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final appointments = stylistController.todaysAppointments;

        if (stylistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (appointments.isEmpty) {
          return const Center(child: Text("No appointments for today."));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: SBSizes.md),
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            return StylistAppointmentCard(appointment: appointments[index]);
          },
        );
      }),
    );
  }
}

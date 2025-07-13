import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/common/stylist_appointment_card.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class UpcomingAppointmentsScreen extends StatelessWidget {
  const UpcomingAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stylistController = Get.find<StylistController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Upcoming Appointments",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final appointments = stylistController.upcomingAppointments;

        if (stylistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (appointments.isEmpty) {
          return const Center(child: Text("No upcoming appointments."));
        }

        // Group appointments by date (yyyy-MM-dd)
        final Map<String, List<Map<String, dynamic>>> grouped = {};
        for (var appt in appointments) {
          final dateStr = appt['date'];
          final date = DateTime.tryParse(dateStr ?? '') ?? DateTime.now();
          final key = DateFormat('yyyy-MM-dd').format(date);
          grouped.putIfAbsent(key, () => []).add(appt);
        }

        // Convert grouped map to sorted list of widgets
        final sortedKeys = grouped.keys.toList()..sort();
        final List<Widget> groupedWidgets = [];

        for (final key in sortedKeys) {
          final date = DateFormat('yyyy-MM-dd').parse(key);
          final formattedDate = DateFormat('MMM dd, yyyy').format(date);

          groupedWidgets.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text(
                formattedDate,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );

          for (final appt in grouped[key]!) {
            groupedWidgets.add(
              StylistAppointmentCard(
                appointment: appt,
              ),
            );
          }
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: SBSizes.lg),
          children: groupedWidgets,
        );
      }),
    );
  }
}

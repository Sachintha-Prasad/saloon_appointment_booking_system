import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/screens/stylist/common/stylist_request_card.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class AppointmentRequestsScreen extends StatelessWidget {
  const AppointmentRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stylistController = Get.find<StylistController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Appointment Requests",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final appointments = stylistController.appointmentRequests;

        if (stylistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (appointments.isEmpty) {
          return const Center(child: Text("No appointment requests."));
        }

        // Group requests by date string "yyyy-MM-dd"
        final Map<String, List<Map<String, dynamic>>> grouped = {};
        for (var appt in appointments) {
          final dateStr = appt['date'];
          final date = DateTime.tryParse(dateStr ?? '') ?? DateTime.now();
          final key = DateFormat('yyyy-MM-dd').format(date);
          grouped.putIfAbsent(key, () => []).add(appt);
        }

        // Sort dates ascending
        final sortedKeys = grouped.keys.toList()..sort();

        // Build grouped widgets list
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
              StylistRequestCard(
                request: appt,
                onAccept: () => stylistController.acceptAppointment(appt['_id']),
                onReject: () => stylistController.rejectAppointment(appt['_id']),
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

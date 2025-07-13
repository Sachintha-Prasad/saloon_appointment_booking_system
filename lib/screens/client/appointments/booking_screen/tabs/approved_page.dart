import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/data/time_slots/time_slots_data.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/widgets/status_chip.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';
import 'package:intl/intl.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/widgets/empty_state.dart';

class AppointmentApprovedTab extends StatefulWidget {
  const AppointmentApprovedTab({super.key});

  @override
  State<AppointmentApprovedTab> createState() => _AppointmentApprovedTabState();
}

class _AppointmentApprovedTabState extends State<AppointmentApprovedTab> {
  final ApiService apiService = Get.find<ApiService>();

  List<Map<String, dynamic>> approvedAppointments = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchApprovedAppointments();
  }

  Future<void> fetchApprovedAppointments() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final AuthController authController = Get.find<AuthController>();
      final clientId = authController.currentUser.value?.id;

      final response = await apiService.authenticatedGet(
        "appointments/approved?clientId=$clientId",
      );

      if (response.statusCode == 200) {
        final List<dynamic> appointments = jsonDecode(response.body);

        setState(() {
          approvedAppointments = appointments.cast<Map<String, dynamic>>();
        });
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch data");
        setState(() {
          errorMessage = error['message'] ?? "Failed to fetch data";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _getTimeRangeFromSlotNumber(int? slotNumber) {
    if (slotNumber == null) return 'Unknown';

    final slot = TimeSlotsData.data.firstWhere(
      (s) => s['slotNo'] == slotNumber,
      orElse: () => {},
    );

    final start = slot['startTime'];
    final end = slot['endTime'];

    if (start != null && end != null) {
      try {
        final startTime = DateFormat('HH:mm').parse(start);
        final endTime = DateFormat('HH:mm').parse(end);
        return '${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(endTime)}';
      } catch (_) {
        return '$start - $end';
      }
    }
    return 'Time not specified';
  }

  String _formatTimeSlot(Map<String, dynamic> appointment) {
    return _getTimeRangeFromSlotNumber(appointment['slotNumber']);
  }

  Widget buildAppointmentCard(Map<String, dynamic> appointment) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Handle stylistId - it's now an object in the API response
    String stylistName = 'Unknown';

    if (appointment['stylistId'] is Map<String, dynamic>) {
      // stylistId is an object (populated)
      final stylistObj = appointment['stylistId'] as Map<String, dynamic>;
      final name = stylistObj['name']?.toString();
      if (name != null && name.isNotEmpty) {
        stylistName = name
            .split(' ')
            .map((w) => w.isNotEmpty
                ? w[0].toUpperCase() + w.substring(1).toLowerCase()
                : '')
            .join(' ');
      }
    } else {
      // Fallback: stylistId is a string (not populated) - try to find in stylist list
      final stylistIdString = appointment['stylistId']?.toString();
      if (stylistIdString != null) {
        final stylist = Get.find<UserController>()
            .stylistList
            .firstWhereOrNull((s) => s.id == stylistIdString);
        if (stylist != null) {
          stylistName = stylist.name
              .split(' ')
              .map((w) => w.isNotEmpty
                  ? w[0].toUpperCase() + w.substring(1).toLowerCase()
                  : '')
              .join(' ');
        }
      }
    }

    // Format the stylist name
    final formattedStylistName = stylistName != null
        ? stylistName
            .split(' ')
            .map((w) => w.isNotEmpty
                ? w[0].toUpperCase() + w.substring(1).toLowerCase()
                : '')
            .join(' ')
        : 'Unknown';

    final DateTime parsedDate =
        DateTime.tryParse(appointment['date'] ?? '') ?? DateTime.now();
    final String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);
    final String timeSlot = _formatTimeSlot(appointment);
    final String status = appointment['status'] ?? 'Approved';

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.2)
                  : const Color.fromARGB(255, 117, 117, 117).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDarkMode
                ? Colors.grey[700]!
                : const Color.fromARGB(42, 0, 132, 172),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          timeSlot,
                          style: TextStyle(
                            fontSize: 14,
                            color: SBColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stylist: $formattedStylistName',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status chip
                  _buildStatusChip(status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    // return GradientStatusChip(
    //   status: status,
    //   fontSize: 11,
    //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    //   borderRadius: 12,
    //   showIcon: true,
    //   iconSize: 12,
    // );
    return OutlinedStatusChip(
      status: status,
      fontSize: 11,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      borderRadius: 12,
      showIcon: true,
      iconSize: 12,
      borderWidth: 1,
    );
  }

  // Replace your existing build method with this updated version:

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessage != null
            ? Center(child: Text(errorMessage!))
            : approvedAppointments.isEmpty
                ? EmptyState(
                    title: "No Approved Appointments",
                    subtitle:
                        "Your approved appointments will appear here once confirmed by the salon",
                    onRefresh: fetchApprovedAppointments,
                    icon: Icons.event_available_rounded,
                    buttonText: "Refresh",
                  )
                : RefreshIndicator(
                    onRefresh: fetchApprovedAppointments,
                    color: SBColors.primary,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[850]
                            : Colors.white,
                    strokeWidth: 2.5,
                    displacement: 40.0,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount: approvedAppointments.length,
                      itemBuilder: (context, index) =>
                          buildAppointmentCard(approvedAppointments[index]),
                    ),
                  );
  }
}

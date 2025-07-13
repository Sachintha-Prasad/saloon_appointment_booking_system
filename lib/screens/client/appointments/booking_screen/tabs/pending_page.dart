import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/data/time_slots/time_slots_data.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/widgets/status_chip.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/widgets/empty_state.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';
import 'package:intl/intl.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class AppointmentPendingTab extends StatefulWidget {
  const AppointmentPendingTab({super.key});

  @override
  State<AppointmentPendingTab> createState() => _AppointmentPendingTabState();
}

class _AppointmentPendingTabState extends State<AppointmentPendingTab> {
  final ApiService apiService = Get.find<ApiService>();

  List<Map<String, dynamic>> pendingAppointments = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPendingAppointments();
  }

  Future<void> fetchPendingAppointments() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final AuthController authController = Get.find<AuthController>();
      final clientId = authController.currentUser.value?.id;

      final response = await apiService.authenticatedGet(
        "appointments/pending?clientId=$clientId",
      );

      if (response.statusCode == 200) {
        final List<dynamic> appointments = jsonDecode(response.body);

        setState(() {
          pendingAppointments = appointments.cast<Map<String, dynamic>>();
        });
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch data");
        setState(() {
          errorMessage = error['message'] ?? "Failed to fetch data";
        });
        debugPrint(errorMessage);
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

  Future<void> _cancelAppointment(String appointmentId) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content:
            const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          // “No” button – just change the text (foreground) colour.
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey, // text/icon colour
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),

          // “Yes” button – filled background + white text.
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SBColors.errorColor, // button fill
              foregroundColor: Colors.white, // text/icon colour
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await apiService.authenticatedPut(
        'appointments/$appointmentId/cancel',
        {},
      );

      if (response.statusCode == 200) {
        await fetchPendingAppointments();
        SBHelperFunctions.showDarkSnackbar(
          'Appointment Cancelled',
        );
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to cancel");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to cancel appointment: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
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
    final appointmentId = appointment['_id'] as String;

    String? stylistName;
    String? stylistIdString;

    if (appointment['stylistId'] is Map<String, dynamic>) {
      final stylistObj = appointment['stylistId'] as Map<String, dynamic>;
      stylistName = stylistObj['name']?.toString();
      stylistIdString = stylistObj['_id']?.toString();
    } else {
      stylistIdString = appointment['stylistId']?.toString();
    }

    if (stylistName == null && stylistIdString != null) {
      final stylist = Get.find<UserController>()
          .stylistList
          .firstWhereOrNull((s) => s.id == stylistIdString);
      stylistName = stylist?.name;
    }

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
    final String status = appointment['status'] ?? 'Pending';

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
        child: IntrinsicHeight(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 8),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusChip(status, isDarkMode),
                    // --- MODIFIED: Cancel button is now a standard ElevatedButton ---
                    SizedBox(
                      height: 24,
                      child: TextButton(
                        onPressed: () => _cancelAppointment(appointmentId),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          // backgroundColor: Colors.redAccent.withOpacity(0.9),
                          foregroundColor: Colors.red,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, bool isDarkMode) {
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessage != null
            ? Center(child: Text(errorMessage!))
            : pendingAppointments.isEmpty
                ? EmptyState(
                    title: "No Pending Appointments",
                    subtitle: "",
                    onRefresh: fetchPendingAppointments,
                    icon: Icons.access_time_rounded,
                    buttonText: "Refresh",
                  )
                : RefreshIndicator(
                    onRefresh: fetchPendingAppointments,
                    color: SBColors.primary,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[850]
                            : Colors.white,
                    strokeWidth: 2.5,
                    displacement: 40.0,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount: pendingAppointments.length,
                      itemBuilder: (context, index) =>
                          buildAppointmentCard(pendingAppointments[index]),
                    ),
                  );
  }
}

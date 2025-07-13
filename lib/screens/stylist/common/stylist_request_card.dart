import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saloon_appointment_booking_system/data/time_slots/time_slots_data.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class StylistRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const StylistRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  String _getTimeSlot(String slot) {
    final int? slotNumber = int.tryParse(slot);
    if (slotNumber == null) return "Unknown time";

    final slotData = TimeSlotsData.data.firstWhere(
          (e) => e['slotNo'] == slotNumber,
      orElse: () => {},
    );

    if (slotData.isEmpty) return "Unknown time";

    return "${slotData['startTime']} - ${slotData['endTime']}";
  }

  String _getTimeFromDate(String? dateString) {
    final DateTime date = DateTime.tryParse(dateString ?? '') ?? DateTime.now();
    return DateFormat('h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final client = request['clientId'] ?? {};
    final name = SBHelperFunctions.capitalizeString(client['name']) ?? 'Unknown';
    final email = client['email'] ?? '';
    final slot = request['slotNumber']?.toString() ?? '-';

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 4),
                    Text(email, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text("Slot: $slot",
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: SBSizes.md),
                        Text(_getTimeSlot(slot),
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      backgroundColor: SBColors.successColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text("Accept"),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onReject,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      backgroundColor: SBColors.errorColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text("Reject"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

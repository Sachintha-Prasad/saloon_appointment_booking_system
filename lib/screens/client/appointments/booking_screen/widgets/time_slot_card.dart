import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';

class TimeSlotCard extends StatelessWidget {
  final int slotNo;
  final String startTime;
  final String endTime;
  final bool isBooked;

  const TimeSlotCard({
    super.key,
    required this.slotNo,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return GestureDetector(
      onTap: () => userController.selectedTimeSlot.value = slotNo,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isBooked ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isBooked ? Colors.blue : Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(startTime, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(endTime, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

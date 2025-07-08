import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TimeSlotCardSkeleton extends StatelessWidget {
  const TimeSlotCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: SBColors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 24,
              width: 200,
              color: SBColors.grey,
            ),
            Container(
              height: 24,
              width: 80,
              color: SBColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

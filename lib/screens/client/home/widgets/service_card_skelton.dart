import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class ServiceCardSkeleton extends StatelessWidget {
  const ServiceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Stack(
        children: [
          // image Placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(SBSizes.borderRadiusLg),
            child: Container(
              width: double.infinity,
              color: SBColors.darkGrey.withOpacity(0.1),
            ),
          ),

          // price Section Placeholder
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: SBSizes.md, vertical: SBSizes.sm),
              decoration: BoxDecoration(
                color: SBColors.darkGrey.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 50,
                    color: SBColors.darkGrey,
                  ),
                  const SizedBox(height: SBSizes.xs),
                  Container(
                    height: 16,
                    width: 120,
                    color: SBColors.darkGrey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

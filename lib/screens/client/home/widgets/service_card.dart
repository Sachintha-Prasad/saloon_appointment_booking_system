import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/models/service_model.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(SBSizes.borderRadiusLg),
          child: Image.network(
            service.serviceImageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50);
            },
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: SBSizes.defaultSpace, vertical: SBSizes.xs),
            decoration: BoxDecoration(
              color: SBColors.primary.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              SBHelperFunctions.capitalizeString(service.name), style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: SBColors.white),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: SBSizes.md, vertical: SBSizes.sm),
            decoration: BoxDecoration(
              color: SBColors.bgDark.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: SBColors.white),
                ),
                Text("${service.price.toString()}.00LKR", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: SBColors.white))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

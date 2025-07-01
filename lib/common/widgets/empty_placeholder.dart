import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';


class EmptyPlaceholder extends StatelessWidget {
  final String placeholderText;

  const EmptyPlaceholder({super.key, required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    final bool isDark = SBHelperFunctions.isDarkMode(context);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
            children: [
              Image.asset(isDark ? SBImages.emptyImgDark : SBImages.emptyImgLight, width: 75, fit: BoxFit.cover),
              const SizedBox(height: SBSizes.spaceBtwItems),
              Text(placeholderText, style: Theme.of(context).textTheme.bodySmall)
            ]
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/features/auth/lib/auth_header_data.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class AuthHeader extends StatelessWidget {
    final AuthHeaderData authHeaderData;

  const AuthHeader({
    super.key,
    required this.authHeaderData
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          authHeaderData.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: SBSizes.sm),
        Text(
          authHeaderData.subtitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: SBColors.textSecondary),
        ),
      ],
    );
  }
}
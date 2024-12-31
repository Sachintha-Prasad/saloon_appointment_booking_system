import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: isDark ? SBColors.darkGrey : SBColors.grey, thickness: 0.5, indent: 8, endIndent: 8,)),
        Text('or', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: SBColors.textSecondary ),),
        Flexible(child: Divider(color: isDark ? SBColors.darkGrey : SBColors.grey, thickness: 0.5, indent: 8, endIndent: 8,))
      ],
    );
  }
}
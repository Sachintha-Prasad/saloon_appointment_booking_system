import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class StylistCard extends StatefulWidget {
  final UserModel stylist;
  final bool isSelected;
  final VoidCallback onTap;

  const StylistCard({
    super.key,
    required this.stylist,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _StylistCardState createState() => _StylistCardState();
}

class _StylistCardState extends State<StylistCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 160, // Adjust card width as needed
        decoration: BoxDecoration(
          color: widget.isSelected ? SBColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.isSelected ? SBColors.primary : SBColors.darkGrey.withOpacity(0.3),
            width: SBSizes.borderWidth,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SBHelperFunctions.capitalizeString(widget.stylist.name) ?? "Unknown",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: widget.isSelected ? SBColors.primary : null, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "Stylist",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: widget.isSelected ? SBColors.primary : null),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

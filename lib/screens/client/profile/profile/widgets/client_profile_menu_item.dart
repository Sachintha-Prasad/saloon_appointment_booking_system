import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class ClientProfileMenuItem extends StatelessWidget {
  final String itemText;
  final Color? textColor;
  final IconData prefixIcon;
  final Color? prefixIconColor;
  final VoidCallback onTap;
  final bool? isTrailingIconVisible;

  const ClientProfileMenuItem({
    required this.itemText,
    this.textColor,
    required this.prefixIcon,
    this.prefixIconColor = SBColors.primary,
    required this.onTap,
    this.isTrailingIconVisible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          color: prefixIconColor?.withOpacity(0.1),
        ),
        child: Icon(prefixIcon, size: SBSizes.iconMd, color: prefixIconColor,),
      ),
      title: Text(itemText, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),),
      trailing: isTrailingIconVisible == true ? Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          color: SBColors.grey.withOpacity(0.1),
        ),
        child: const Icon(Icons.chevron_right_outlined, size: SBSizes.iconMd,),
      ) : null,
    );
  }
}
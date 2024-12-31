import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class CustomTextButton extends StatelessWidget {
  final ButtonType? btnType;
  final String? btnText;
  final Widget? prefixIcon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final ButtonStyle? customStyle;

  const CustomTextButton({
    super.key,
    this.btnText,
    this.btnType = ButtonType.primary,
    this.backgroundColor,
    this.prefixIcon,
    this.customStyle,
    this.onPressed,
  });

  ButtonStyle _getButtonStyle(BuildContext context) {
    final Color bgColor = backgroundColor ?? _getBackgroundColor(context);
    final Color textColor = _getTextColor(context);

    if (btnType == ButtonType.bordered) {
      return OutlinedButton.styleFrom(
        side: const BorderSide(
            color: SBColors.primary, width: SBSizes.borderWidth),
        foregroundColor: SBColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: SBSizes.xl,
          vertical: SBSizes.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SBSizes.buttonRadius),
        ),
      );
    } else {
      return TextButton.styleFrom(
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(
          horizontal: SBSizes.xl,
          vertical: SBSizes.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SBSizes.buttonRadius),
        ),
        backgroundColor: bgColor,
      );
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (btnType) {
      case ButtonType.primary:
        return SBColors.primaryButton;
      case ButtonType.secondary:
        return SBColors.secondaryButton;
      case ButtonType.danger:
        return SBColors.dangerButton;
      default:
        return Colors.transparent; // Transparent for bordered or other buttons
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (btnType) {
      case ButtonType.bordered:
        return SBColors.primary;
      default:
        return SBColors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: btnType == ButtonType.bordered
          ? OutlinedButton(
              style: customStyle ?? _getButtonStyle(context),
              onPressed: onPressed,
              child: _buildButtonContent(context),
            )
          : TextButton(
              style: customStyle ?? _getButtonStyle(context),
              onPressed: onPressed,
              child: _buildButtonContent(context),
            ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final Color textColor = _getTextColor(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: SBSizes.spaceBtwItems),
        ],
        Text(
          btnText ?? '',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: textColor, fontSize: SBSizes.fontSizeSm),
        ),
      ],
    );
  }
}

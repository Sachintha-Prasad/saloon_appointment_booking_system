import "package:flutter/material.dart";
import "package:saloon_appointment_booking_system/utils/constants/colors.dart";
import "package:saloon_appointment_booking_system/utils/constants/sizes.dart";
import "package:saloon_appointment_booking_system/utils/helper/helper_functions.dart";

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscured;
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = SBHelperFunctions.isDarkMode(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      focusNode: _focusNode,
      style: Theme.of(context).textTheme.bodyMedium,
      cursorColor: const Color(0xFF0083ac),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: isDark ?
          (isFocused ? SBColors.primary : SBColors.inputPlaceholderDark) :
          (isFocused ? SBColors.primary : SBColors.inputPlaceholderLight)
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color:  isFocused ? SBColors.primary : SBColors.grey,
          size: SBSizes.iconMd,
        ),
        filled: true,
        fillColor: isDark ? SBColors.inputFieldBgDark : SBColors.inputFieldBgLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SBSizes.inputFieldRadius),
          borderSide: const BorderSide(
            color: SBColors.grey,
            width: SBSizes.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SBSizes.inputFieldRadius),
          borderSide: const BorderSide(
            color: SBColors.primary,
            width: SBSizes.borderWidth,
          ),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: isObscured ? SBColors.grey : SBColors.primary,
            size: SBSizes.iconMd,
          ),
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
        )
            : null,
      ),
    );
  }
}

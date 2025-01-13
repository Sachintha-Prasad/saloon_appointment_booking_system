import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/screens/auth/login/login_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';


class RegisterFooter extends StatelessWidget {
  const RegisterFooter({
    super.key,
  });

  // function to navigate login
  void _navigateToLogin(BuildContext context) {
    Get.to(const LogInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // google login button
        CustomTextButton(
          btnText: 'Join With Google',
          btnType: ButtonType.bordered,
          prefixIcon:
          SvgPicture.asset(SBImages.googleIcon),
          onPressed: () {
            print('Custom styled button pressed');
          },
        ),
        const SizedBox(height: SBSizes.md),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Already have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium),
            const SizedBox(
              width: SBSizes.spaceBtwItems,
            ),

            GestureDetector(
                onTap: () => _navigateToLogin(context),
                child: Text('Sign In',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        color: SBColors.primary,
                        fontWeight: FontWeight.w600)))
          ],
        )
      ],
    );
  }
}
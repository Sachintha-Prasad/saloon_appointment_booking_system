import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/register/register_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class LogInFooter extends StatelessWidget {
  const LogInFooter({
    super.key,
  });

  // function to navigate register
  void _navigateToRegister(BuildContext context) {
    Get.to(const RegisterScreen(), duration: const Duration(milliseconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // google logIn button
        CustomTextButton(
          btnText: 'Log In With Google',
          btnType: ButtonType.bordered,
          prefixIcon:
          SvgPicture.asset(SBImages.googleIcon),
          onPressed: () {
            print('Log In with google clicked!');
          },
        ),
        const SizedBox(height: SBSizes.md),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Don’t have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium),
            const SizedBox(
              width: SBSizes.spaceBtwItems,
            ),

            GestureDetector(
                onTap: () => _navigateToRegister(context),
                child: Text('Join Now',
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
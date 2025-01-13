import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/screens/auth/login/login_screen.dart';
import 'package:saloon_appointment_booking_system/screens/auth/register/register_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: SBSpacingStyle.paddingMainLayout,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Welcome,",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "To the Saloon Blue",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  SizedBox(height: SBSizes.defaultSpace),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: CustomTextButton(btnType: ButtonType.bordered, btnText: "Log In", onPressed: ()=> {Get.to(LogInScreen())},)),
                      SizedBox(width: SBSizes.md),
                      Expanded(child: CustomTextButton(btnText: "Register", onPressed: ()=> {Get.to(RegisterScreen())},)),
                    ],
                  )

                ],
              ),
            ),
      )),
    );
  }
}

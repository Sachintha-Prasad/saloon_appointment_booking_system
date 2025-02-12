import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class OnboardingPage extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback onLoginPressed;

  const OnboardingPage({
    super.key,
    required this.img,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // background image
        Image.asset(
          img,
          fit: BoxFit.cover,
        ),

        // content
        Positioned(
          bottom: SBSizes.xxl,
          left: SBSizes.lg,
          right: SBSizes.lg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: SBColors.white),
              ),
              const SizedBox(height: SBSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: SBColors.lightGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SBSizes.spaceBtwSections),
              CustomTextButton(
                btnText: buttonText,
                onPressed: onButtonPressed,
              ),
              const SizedBox(height: SBSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: SBColors.white),
                  ),
                  const SizedBox(width: SBSizes.spaceBtwItems),
                  GestureDetector(
                    onTap: onLoginPressed,
                    child: Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                          color: SBColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

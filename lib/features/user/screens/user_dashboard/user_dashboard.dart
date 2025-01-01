import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/features/auth/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/features/user/screens/user_profile/user_profile.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: SBSpacingStyle.paddingMainLayout,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Antony,",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),

              Text(
                'Find the service you want, and treat yourself',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),

              CustomTextButton(btnText: "Profile", onPressed: ()=>Get.to(const UserProfile()),),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/profile_image.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/profile/profile/user_profile_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';

class StylistDashboardHeader extends StatelessWidget {
  final UserModel userData;

  StylistDashboardHeader({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImage(userData: userData),
        const SizedBox(width: SBSizes.md),

        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SBHelperFunctions.capitalizeString(userData.name),
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Stylist',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: SBColors.darkGrey),
              ),
              const SizedBox(height: SBSizes.sm),
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  btnText: 'View profile',
                  btnType: ButtonType.primary,
                  onPressed: () {
                    Get.to(() => UserProfileScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

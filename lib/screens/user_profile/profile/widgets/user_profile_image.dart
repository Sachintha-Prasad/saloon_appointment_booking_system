import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/user_profile/edit_profile/edit_profile_image_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.userData,
  });

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Navigate to EditProfilePictureScreen and wait for it to return
        await Get.to(() => EditProfilePictureScreen());
        // Trigger UI update after returning (if any changes were made)
        userData.profileImg;
      },
      child: SizedBox(
        width: SBSizes.avatarWidth,
        height: SBSizes.avatarHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SBSizes.avatarRadius),
          child: Obx(() {
            final profileImg = userData.profileImg;
            final displayName = userData.name;

            // Render user profile image or fallback avatar
            return profileImg != null
                ? Image.network(
                    profileImg,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback in case the network image fails
                      return CircleAvatar(
                        radius: SBSizes.avatarWidth / 2,
                        backgroundColor: SBColors.primary,
                        child: Text(
                          SBHelperFunctions.getAvatarLetters(displayName),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      );
                    },
            )
                : CircleAvatar(
                    radius: SBSizes.avatarWidth / 2,
                    backgroundColor: SBColors.primary,
                    child: Text(
                      SBHelperFunctions.getAvatarLetters(displayName),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                    ),
                );
            }
          ),
        ),
      ),
    );
  }
}

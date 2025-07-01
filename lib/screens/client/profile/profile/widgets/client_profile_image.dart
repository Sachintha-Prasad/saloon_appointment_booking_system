import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/edit_profile/edit_profile_image_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class ClientProfileImage extends StatefulWidget {
  const ClientProfileImage({
    super.key,
    required this.userData,
  });

  final UserModel userData;

  @override
  _ClientProfileImageState createState() => _ClientProfileImageState();
}

class _ClientProfileImageState extends State<ClientProfileImage> {
  late String? profileImg;

  @override
  void initState() {
    super.initState();
    profileImg = widget.userData.profileImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Navigate to EditProfilePictureScreen and wait for it to return
        final updatedImage = await Get.to(() => const EditProfilePictureScreen());


        // Update profile image if changed
        if (updatedImage != null && updatedImage is String) {
          setState(() {
            profileImg = updatedImage;
          });
        }
      },
      child: SizedBox(
        width: SBSizes.avatarWidth,
        height: SBSizes.avatarHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SBSizes.avatarRadius),
          child: profileImg != null
              ? Image.network(
            profileImg!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildFallbackAvatar();
            },
          )
              : _buildFallbackAvatar(),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return CircleAvatar(
      radius: SBSizes.avatarWidth / 2,
      backgroundColor: SBColors.primary,
      child: Text(
        SBHelperFunctions.getAvatarLetters(widget.userData.name),
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}


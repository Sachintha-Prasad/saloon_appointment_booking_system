import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/profile_image.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/profile/edit_profile/edit_profile_image_screen.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({
    super.key,
    required this.userData,
  });

  final UserModel userData;

  @override
  _UserProfileImageState createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
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
      child: ProfileImage(userData: widget.userData)
    );
  }
}


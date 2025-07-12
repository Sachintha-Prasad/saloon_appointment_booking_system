import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
    required this.userData,
  });

  final UserModel userData;

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late String? profileImg;

  @override
  void initState() {
    super.initState();
    profileImg = widget.userData.profileImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }

  Widget _buildFallbackAvatar() {
    return CircleAvatar(
      radius: SBSizes.avatarWidth / 2,
      backgroundColor: SBColors.red,
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


import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/screens/user_profile/profile/widgets/user_profile_menu_item.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // edit profile
        UserProfileMenuItem(itemText: "Edit Profile",
          prefixIcon: Icons.person_outline,
          onTap: () => {} ,
        ),
        // help
        UserProfileMenuItem(itemText: "Help",
          prefixIcon: Icons.help_outline_outlined,
          onTap: () => {},
        ),
        // privacy policy
        UserProfileMenuItem(itemText: "Privacy Policy",
          prefixIcon: Icons.privacy_tip_outlined,
          onTap: () => {},
        ),
        // invite friends
        UserProfileMenuItem(itemText: "Invite Friends",
          prefixIcon: Icons.groups_outlined,
          onTap: () => {},
        ),
      ],
    );
  }
}
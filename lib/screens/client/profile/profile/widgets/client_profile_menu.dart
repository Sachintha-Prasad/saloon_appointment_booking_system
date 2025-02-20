import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/profile/widgets/client_profile_menu_item.dart';

class ClientProfileMenu extends StatelessWidget {
  const ClientProfileMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // edit profile
        ClientProfileMenuItem(itemText: "Edit Profile",
          prefixIcon: Icons.person_outline,
          onTap: () => {} ,
        ),
        // help
        ClientProfileMenuItem(itemText: "Help",
          prefixIcon: Icons.help_outline_outlined,
          onTap: () => {},
        ),
        // privacy policy
        ClientProfileMenuItem(itemText: "Privacy Policy",
          prefixIcon: Icons.privacy_tip_outlined,
          onTap: () => {},
        ),
        // invite friends
        ClientProfileMenuItem(itemText: "Invite Friends",
          prefixIcon: Icons.groups_outlined,
          onTap: () => {},
        ),
      ],
    );
  }
}
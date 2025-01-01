import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/features/auth/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/features/user/screens/user_profile/user_profile_menu.dart';
import 'package:saloon_appointment_booking_system/features/user/screens/user_profile/user_profile_menu_item.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = SBHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: Get.back, icon: const Icon(Icons.chevron_left)),
        title: Text("Profile", style: Theme.of(context).textTheme.headlineSmall,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SBSizes.sm),
            child: IconButton(onPressed: ()=>{},
              icon: isDark ?
                const Icon(Icons.light_mode_outlined, size: SBSizes.iconMd,) :
                const Icon(Icons.dark_mode_outlined, size: SBSizes.iconMd),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SBSizes.defaultSpace),
          child: Column(
            children: [
              // user details section===============================================================================
              Center(
                child: Column(
                  children: [
                    // user image
                    SizedBox(
                      width: SBSizes.avatarWidth,
                      height: SBSizes.avatarHeight,
                      child: ClipRRect(borderRadius: BorderRadius.circular(SBSizes.avatarRadius),
                          child: Image(image: AssetImage(SBImages.avatarImg))
                      ),
                    ),
                    const SizedBox(height: SBSizes.sm,),

                    // user name
                    Text('Antony Perera', style: Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox(height: SBSizes.xs,),

                    // user email
                    Text('antonyperera@gmail.com', style: Theme.of(context).textTheme.bodyMedium,),
                    const SizedBox(height: SBSizes.md,),
                  ],
                ),
              ),
              const SizedBox(height: SBSizes.spaceBtwSections,),

              // profile divider===================================================================================
              const Divider(),
              const SizedBox(height: SBSizes.spaceBtwSections,),

              // menu section======================================================================================
              const UserProfileMenu(),
              const SizedBox(height: SBSizes.spaceBtwSections,),

              // profile divider===================================================================================
              const Divider(),
              const SizedBox(height: SBSizes.spaceBtwSections,),

              // log out button=====================================================================================
              UserProfileMenuItem(itemText: "Log Out",
                prefixIcon: Icons.logout_outlined,
                prefixIconColor: SBColors.red,
                isTrailingIconVisible: false,
                textColor: SBColors.red,
                onTap: () => AuthRepository.instance.logOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

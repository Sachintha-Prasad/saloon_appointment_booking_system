import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/theme_toggle_button.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/profile/widgets/client_profile_image.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/profile/widgets/client_profile_menu.dart';
import 'package:saloon_appointment_booking_system/screens/client/profile/profile/widgets/client_profile_menu_item.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = StorageService.getUser();
    final AuthController authController = Get.put(AuthController());


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: Theme.of(context).textTheme.headlineSmall,),
        actions: const [ThemeToggleButton()],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SBSizes.defaultSpace),
          child: FutureBuilder(
            future: currentUser,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  UserModel userData = snapshot.data as UserModel;

                  return Column(
                    children: [
                      // user details section===============================================================================
                      Center(
                        child: Column(
                          children: [
                            // user profile image
                            ClientProfileImage(userData: userData),
                            const SizedBox(height: SBSizes.sm,),

                            // user name
                            Text(userData.name.capitalize!, style: Theme.of(context).textTheme.headlineMedium,),
                            const SizedBox(height: SBSizes.xs,),

                            // user email
                            Text(userData.email, style: Theme.of(context).textTheme.bodyMedium,),
                            const SizedBox(height: SBSizes.md,),
                          ],
                        ),
                      ),
                      const SizedBox(height: SBSizes.spaceBtwSections,),

                      // profile divider===================================================================================
                      const Divider(),
                      const SizedBox(height: SBSizes.spaceBtwSections,),

                      // menu section======================================================================================
                      const ClientProfileMenu(),
                      const SizedBox(height: SBSizes.spaceBtwSections,),

                      // profile divider===================================================================================
                      const Divider(),
                      const SizedBox(height: SBSizes.spaceBtwSections,),

                      // log out button=====================================================================================
                      ClientProfileMenuItem(itemText: "Log Out",
                        prefixIcon: Icons.logout_outlined,
                        prefixIconColor: SBColors.red,
                        isTrailingIconVisible: false,
                        textColor: SBColors.red,
                        onTap: () => authController.logout(),
                      ),
                    ],
                  );
                } else if(snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}



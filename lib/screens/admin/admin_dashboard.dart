import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/user_profile/profile/user_profile_screen.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = StorageService.getUser();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: SBSpacingStyle.paddingMainLayout,
          child: FutureBuilder(
              future: currentUser,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    UserModel userData = snapshot.data as UserModel;

                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Admin ${SBHelperFunctions.getFirstName(userData.name)},",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'Find the service you want, and treat yourself',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),

                        CustomTextButton(btnText: "Profile", onPressed: ()=>Get.to(const UserProfileScreen()),),
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
              }),
        ),
      ),
    );
  }
}

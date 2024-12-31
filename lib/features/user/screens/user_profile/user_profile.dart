import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = SBHelperFunctions.isDarkMode(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: Get.back, icon: const Icon(Icons.chevron_left)),
        title: Center(child: Text("Profile", style: Theme.of(context).textTheme.headlineSmall,)),
        actions: [
          IconButton(onPressed: ()=>{}, icon: isDark ?
            const Icon(Icons.light_mode_outlined, size: SBSizes.iconMd,) :
            const Icon(Icons.dark_mode_outlined, size: SBSizes.iconMd),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}

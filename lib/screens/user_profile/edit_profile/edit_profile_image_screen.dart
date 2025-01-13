import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/screens/user_profile/profile/user_profile_screen.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';

class EditProfilePictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile Picture")),
      body: SingleChildScrollView(
        padding: SBSpacingStyle.paddingMainLayout,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the selected image or a placeholder
            Obx(() {
              return CircleAvatar(
                radius: 60,
                backgroundImage: userController.selectedImage.value != null
                    ? FileImage(userController.selectedImage.value!)
                    : AssetImage(SBImages.avatarImg) as ImageProvider,
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => userController.pickImage(ImageSource.gallery),
              child: Text("Choose Image"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => userController.pickImage(ImageSource.camera),
              child: Text("Take a picture"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (userController.selectedImage.value != null) {
                  await userController.saveProfilePicture();

                  // Fetch updated user data and re-render profile screen
                  await userController.getUserData();

                  // Navigate back to UserProfileScreen
                  Get.off(() => UserProfileScreen());
                } else {
                  Get.snackbar("Error", "Please select an image first");
                }
              },
              child: Text("Save"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => userController.clearSelectedImage(),
              child: Text("Clear"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => userController.deleteProfileImage(),
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}

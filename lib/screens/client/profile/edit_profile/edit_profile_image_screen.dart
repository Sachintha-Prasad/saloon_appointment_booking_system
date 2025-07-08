import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/controllers/profile_picture_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class EditProfilePictureScreen extends StatelessWidget {
  const EditProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profilePictureController = Get.put(ProfilePictureController());

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile Picture")),
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
                backgroundImage: profilePictureController.selectedImage.value != null
                    ? FileImage(profilePictureController.selectedImage.value!)
                    : AssetImage(SBImages.avatarImg) as ImageProvider,
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => profilePictureController.pickImage(ImageSource.gallery),
              child: const Text("Choose Image"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => profilePictureController.pickImage(ImageSource.camera),
              child: const Text("Take a picture"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (profilePictureController.selectedImage.value != null) {
                  await profilePictureController.updateProfilePicture();

                  Get.back();
                } else {
                  SBHelperFunctions.showSnackbar("please select an image first");
                }
              },
              child: const Text("Save"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => profilePictureController.clearSelectedImage(),
              child: const Text("Clear"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => {},
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}

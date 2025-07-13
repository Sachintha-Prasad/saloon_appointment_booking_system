import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_bottom_sheet.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/profile_picture_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';  // Import your custom button
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';

class EditProfilePictureScreen extends StatelessWidget {
  const EditProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profilePictureController = Get.put(ProfilePictureController());
    final AuthController authController = Get.find<AuthController>();

    final screenHeight = MediaQuery.of(context).size.height;
    final avatarSize = screenHeight * 0.45;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile Picture")),
      body: Padding(
        padding: SBSpacingStyle.paddingMainLayout,
        child: Obx(() {
          final selectedImage = profilePictureController.selectedImage.value;
          final profileImageUrl = authController.currentUser.value?.profileImageUrl;

          ImageProvider imageProvider;
          if (selectedImage != null) {
            imageProvider = FileImage(selectedImage);
          } else if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
            imageProvider = NetworkImage(profileImageUrl);
          } else {
            imageProvider = const AssetImage('assets/images/default_avatar.png');
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => _showImagePickerOptions(profilePictureController),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: avatarSize / 2,
                      backgroundImage: imageProvider,
                    ),
                    Positioned(
                      bottom: 32,
                      right: 48,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.edit, size: 20, color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomTextButton(
                      btnText: "Clear",
                      btnType: ButtonType.bordered,
                      onPressed: () => profilePictureController.clearSelectedImage(),
                    ),
                  ),
                  const SizedBox(width: SBSizes.md),
                  Expanded(
                    child: CustomTextButton(
                      btnText: "Delete",
                      btnType: ButtonType.danger,
                      prefixIcon: const Icon(Icons.delete_forever, color: Colors.red, size: 20),
                      onPressed: () {
                        // TODO: implement delete functionality
                        SBHelperFunctions.showSnackbar("Delete not implemented yet.");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SBSizes.md),
              CustomTextButton(
                btnText: "Save",
                prefixIcon: const Icon(Icons.save, color: Colors.white),
                btnType: ButtonType.primary,
                onPressed: () async {
                  if (profilePictureController.selectedImage.value != null) {
                    await profilePictureController.updateProfilePicture();
                  } else {
                    SBHelperFunctions.showSnackbar("Please select an image first");
                  }
                }
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showImagePickerOptions(ProfilePictureController controller) {
    CustomBottomSheet.show(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Profile Picture',
                  style: Theme.of(Get.context!).textTheme.titleLarge,
                ),
                const SizedBox(height: SBSizes.xs),
                Text(
                  'Choose how you want to add your photo.',
                  style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: SBSizes.lg),

          // Gallery Option
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.image, color: Colors.blue),
            title: const Text("Choose from Gallery"),
            onTap: () {
              controller.pickImage(ImageSource.gallery);
              CustomBottomSheet.close();
            },
          ),
          const SizedBox(height: SBSizes.sm),

          // Camera Option
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.camera_alt, color: Colors.orange),
            title: const Text("Take a Picture"),
            onTap: () {
              controller.pickImage(ImageSource.camera);
              CustomBottomSheet.close();
            },
          ),
          const SizedBox(height: SBSizes.sm),

          // Cancel Option
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.close, color: Colors.redAccent),
            title: const Text("Cancel"),
            onTap: () => CustomBottomSheet.close(),
          ),
        ],
      ),
    );
  }
}

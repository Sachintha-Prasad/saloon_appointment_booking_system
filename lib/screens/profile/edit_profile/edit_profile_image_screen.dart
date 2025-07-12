import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/profile_picture_controller.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

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
                      bottom: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.edit, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOutlinedButton(
                    label: "Clear",
                    icon: Icons.clear,
                    onPressed: () => profilePictureController.clearSelectedImage(),
                  ),
                  _buildOutlinedButton(
                    label: "Delete",
                    icon: Icons.delete_forever,
                    color: Colors.red,
                    onPressed: () {
                      // TODO: implement delete functionality
                      SBHelperFunctions.showSnackbar("Delete not implemented yet.");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  if (profilePictureController.selectedImage.value != null) {
                    await profilePictureController.updateProfilePicture();
                  } else {
                    SBHelperFunctions.showSnackbar("Please select an image first");
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.black,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(label, style: TextStyle(color: color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    );
  }

  void _showImagePickerOptions(ProfilePictureController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from Gallery"),
              onTap: () {
                controller.pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Picture"),
              onTap: () {
                controller.pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text("Cancel"),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}

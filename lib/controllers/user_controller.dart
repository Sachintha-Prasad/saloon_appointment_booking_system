import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/repositories/user_repository/user_repository.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:image/image.dart' as img;
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _authRepository = Get.put(AuthRepository());
  final _userRepository = Get.put(UserRepository());

  final ImagePicker _imagePicker = ImagePicker();

  late final Rxn<File> selectedImage = Rxn<File>();
  // static String? _cloudinaryPublicId;

  // get user data
  getUserData() {
    final email = _authRepository.firebaseUser.value?.email;

    if(email != null){
     return _userRepository.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: SBColors.errorColor.withOpacity(0.1),
        colorText: SBColors.errorColor
      );
    }
  }

  // upload and update profile img====================================================================================
  // function to pick an image
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);

      // Compress the image to reduce the upload size
      File compressedImage = await _compressImage(selectedImage.value!);

      // Set the compressed image as the selected image
      selectedImage.value = compressedImage;
      update();
    }
  }

  // function to compress image (reduce quality)
  Future<File> _compressImage(File image) async {
    // Read the image file
    final img.Image originalImage = img.decodeImage(image.readAsBytesSync())!;

    // Compress the image by adjusting the quality (0 - 100, lower is more compressed)
    final List<int> compressedBytes = img.encodeJpg(originalImage, quality: 50);  // Set the quality to 50 (lower value = more compression)

    // Create a new file with the compressed bytes
    final compressedFile = await File(image.path).writeAsBytes(compressedBytes);

    return compressedFile;
  }

  // function to clear selected image
  Future<void> clearSelectedImage() async {
    selectedImage.value = null;
    update();
  }

  // function to save the profile picture
  saveProfilePicture(){
    if (selectedImage.value == null) return;

    final email = _authRepository.firebaseUser.value?.email;
    if (email != null) {
      return _userRepository.uploadProfileImg(selectedImage.value!, email);
    } else {
      SBHelperFunctions.showErrorSnackbar("Login to continue");
    }
    update();
  }

  // delete the profile picture
  deleteProfileImage() {
    if (selectedImage.value == null) return;

    final email = _authRepository.firebaseUser.value?.email;
    if (email != null) {
      return _userRepository.deleteProfileImg(email);
    } else {
      SBHelperFunctions.showErrorSnackbar("Login to continue");
    }
    update();
  }
}

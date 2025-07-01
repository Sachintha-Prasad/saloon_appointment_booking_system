import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/services/secure_storage_service.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class ProfilePictureController extends GetxController {
  // cloudinary api configs
  final String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/${dotenv.env['CLOUDINARY_NAME']}/image/upload";
  final String apiKey = dotenv.env["CLOUDINARY_API_KEY"] ?? '';
  final String apiSecret = dotenv.env["CLOUDINARY_API_SECRET"] ?? '';
  final String uploadPreset = dotenv.env["CLOUDINARY_UPLOAD_PRESET"] ?? '';

  final ImagePicker _imagePicker = ImagePicker();
  final ApiService apiService = Get.find<ApiService>();
  final AuthController authController = Get.find<AuthController>();

  final Rxn<File> selectedImage = Rxn<File>();

  // pick image from gallery or camera and compress it
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile == null) {
        SBHelperFunctions.showSnackbar('no image selected, please pick an image to continue.');
        return;
      }

      // original image file
      final File imageFile = File(pickedFile.path);
      selectedImage.value = await _compressImage(imageFile);

      update(); // notify listeners/widgets
    } catch (e) {
      debugPrint('image picking error: $e');
      SBHelperFunctions.showSnackbar('error, failed to pick image.');
    }
  }

  // compress image to reduce file size
  Future<File> _compressImage(File image) async {
    try {
      final img.Image? decodedImage = img.decodeImage(await image.readAsBytes());

      if (decodedImage == null) {
        throw Exception('failed to decode image');
      }

      // compressing to 50% quality
      final List<int> compressedBytes = img.encodeJpg(decodedImage, quality: 50);

      // writing the compressed bytes to a new file
      final compressedFile = await File(image.path).writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      debugPrint('compression error: $e');
      rethrow;
    }
  }

  // clear selected image
  void clearSelectedImage() {
    selectedImage.value = null;
    update();
  }

  // upload image to cloudinary
  Future<String?> _uploadProfileImageToCloudinary(File image) async {
    try {
      final request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl))
        ..fields["upload_preset"] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      final basicAuth = "Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}";
      request.headers['Authorization'] = basicAuth;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200) {
        final secureImgUrl = jsonResponse['secure_url'];
        debugPrint('image uploaded successfully: $secureImgUrl');
        return secureImgUrl;
      } else {
        debugPrint('cloudinary upload failed: ${jsonResponse['error']['message']}');
        throw Exception("cloudinary upload failed");
      }
    } catch (error) {
      debugPrint("cloudinary upload error: $error");
      SBHelperFunctions.showSnackbar('upload error, failed to upload image.');
      return null;
    }
  }

  // update profile picture (PUT request to your backend)
  Future<void> updateProfilePicture() async {
    if (selectedImage.value == null) {
      SBHelperFunctions.showSnackbar('no image selected, please pick an image first.');
      return;
    }

    try {
      final token = await SecureStorageService.getToken();
      final currentUser = authController.currentUser.value;


      if (currentUser == null) {
        SBHelperFunctions.showSnackbar('unauthorized ,please login to update your profile.');
        return;
      }

      // upload image to cloudinary first
      final imageUrl = await _uploadProfileImageToCloudinary(selectedImage.value!);

      if (imageUrl == null) {
        SBHelperFunctions.showSnackbar('upload failed , failed to upload profile image.');
        return;
      }

      // update user in database
      final response = await http.patch(
        Uri.parse('${apiService.baseUrl}/users/${currentUser.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'profileImageUrl': imageUrl
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SBHelperFunctions.showSuccessSnackbar('profile image updated');
        authController.currentUser.value = UserModel.fromJson(responseData);
      } else {
        SBCustomErrorHandler.handleErrorResponse(
            responseData, 'failed to update profile image.');
      }
    } catch (error) {
      debugPrint('profile update Error: $error');
    }
  }
}

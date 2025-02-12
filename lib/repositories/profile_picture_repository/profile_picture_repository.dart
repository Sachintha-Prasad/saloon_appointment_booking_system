import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ProfilePictureRepository extends GetxController {
  static ProfilePictureRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // cloudinary api
  final String cloudinaryUrl = "https://api.cloudinary.com/v1_1/${dotenv.env['CLOUDINARY_NAME']}/image/upload";
  final String apiKey = dotenv.env["CLOUDINARY_API_KEY"] ?? '';
  final String apiSecret = dotenv.env["CLOUDINARY_API_SECRET"] ?? '';
  final String uploadPreset = dotenv.env["CLOUDINARY_UPLOAD_PRESET"] ?? '';

  // upload profile picture
  Future<String?> uploadProfileImg(File image, String email) async {
    try {
      final request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl));
      request.fields["upload_preset"] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      final basicAuth = "Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}";
      request.headers['Authorization'] = basicAuth;

      final response = await request.send();
      final jsonResponse = json.decode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        final secureImgUrl = jsonResponse['secure_url'];
        await _db.collection("users").doc(email).update({"profile_img": secureImgUrl});
        return secureImgUrl;
      } else {
        throw Exception("Cloudinary upload failed");
      }
    } catch (error) {
      print("Upload Error: $error");
      return null;
    }
  }

  // delete profile picture
  Future<void> deleteProfileImg(String email) async {
    try {
      await _db.collection("users").doc(email).update({"profile_img": null});
    } catch (error) {
      print("Delete Error: $error");
    }
  }
}

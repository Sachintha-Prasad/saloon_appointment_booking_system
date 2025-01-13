import 'dart:io';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
 import 'package:http/http.dart' as http;
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // firestore _db that points to firestore
  final _db = FirebaseFirestore.instance;

  // cloudinary API details
  final String cloudinaryName = dotenv.env['CLOUDINARY_NAME'] ?? '';
  final String apiKey = dotenv.env["CLOUDINARY_API_KEY"] ?? '';
  final String apiSecret = dotenv.env["CLOUDINARY_API_SECRET"] ?? '';
  final String uploadPreset = dotenv.env["CLOUDINARY_UPLOAD_PRESET"] ?? '';


  // create user function==========================================================================================================
  Future<void> addUserToFirestore(User? user, UserModel userData) async {
    if (user == null) {
      print("No user to add to Firestore.");
      return;
    }

    try {
      await _db.collection('users').doc(user.uid).set({
        'email': userData.email,
        'name': userData.name,
        'mobile_no': userData.mobileNo,
        'profile_img': userData.profileImg,
        'role': userData.role.toString(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      SBHelperFunctions.showSuccessSnackbar("Your account has been created");
    } catch (error) {
      SBHelperFunctions.showErrorSnackbar( "Something went wrong. Try again");
      print("CreateUser Error: $error");
    }
  }

  // fetch user data
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e)=> UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // fetch all user data --> only for admins #### replace this to admin repository
  Future<List<UserModel>> getAllUserDetails() async {
    final snapshot = await _db.collection("users").get();
    final userData = snapshot.docs.map((e)=> UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  // upload profile picture==============================================================================
  // this function return the img secure url
  Future<void> uploadProfileImg(File image, String email) async {
    var cloudinaryUrl = "https://api.cloudinary.com/v1_1/$cloudinaryName/image/upload";

    try{
      // get the current publicId from Firestore (if it exists)
      final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
      final userDoc = snapshot.docs.first;

      if (snapshot.docs.isEmpty) {
        print("No user found with email: $email");
        return;
      }


      // multipart request
      final request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl));
      request.fields["upload_preset"] = uploadPreset;

      // attach the image file
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      // basic authentication
      final basicAuth = "Basic${base64Encode(utf8.encode('$apiKey:$apiSecret'))}";
      request.headers['Authorization'] = basicAuth;

      print("Request Fields: ${request.fields}");
      print("Request Headers: ${request.headers}");

      // send the request
      final response = await request.send();

      // response data
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);

      print("Response: $jsonResponse");

      if (response.statusCode == 200) {
        final secureImgUrl = jsonResponse['secure_url'];
        print("New Profile Image URL: $secureImgUrl");
        await _db.collection("users").doc(userDoc.id).update({"profile_img": secureImgUrl});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SBHelperFunctions.showSuccessSnackbar("Profile image updated successfully");
        });
      } else {
        SBHelperFunctions.showErrorSnackbar("Cloudinary upload failed");
        print("Cloudinary upload failed: ${jsonResponse['error'] ?? jsonResponse}");
      }
    } catch (error) {
      SBHelperFunctions.showErrorSnackbar("Unknown Error uploading profile image");
      print("Upload Profile Picture Error: $error");
    }
  }

  // delete img when replacing with new img or deleting the img
  Future<void> deleteProfileImg(String email) async {
    try {
      final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
      if (snapshot.docs.isEmpty) {
        print("No user found with email: $email");
        return;
      }

      final userDoc = snapshot.docs.first;
      final currentProfileImg = userDoc["profile_img"];

      if (currentProfileImg != null && currentProfileImg.isNotEmpty) {
        await _db.collection("users").doc(userDoc.id).update({"profile_img": null});
        SBHelperFunctions.showSuccessSnackbar("Profile image URL removed successfully from Firestore.");
        print("Profile image URL removed from Firestore.");
      } else {
        print("No profile image to delete");
        SBHelperFunctions.showSnackbar("No profile image to delete");
      }
    } catch (error) {
      print("Error deleting profile image: $error");
      SBHelperFunctions.showErrorSnackbar("Unknown Error deleting profile image");
    }
  }
}
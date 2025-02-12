import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // firestore _db that points to firestore
  final _db = FirebaseFirestore.instance;

  // create user function==========================================================================================================
  Future<void> addUserToFirestore(User? user, UserModel userData) async {
    if (user == null) {
      print("No user to add to Firestore.");
      return;
    }

    try {
      final docRef = _db.collection('users').doc(user.uid);
      final doc = await docRef.get();

      if (doc.exists) {
        print("User already exists in Firestore.");
        return;
      }

      await docRef.set({
        'email': userData.email,
        'name': userData.name,
        'mobile_no': userData.mobileNo,
        'profile_img': userData.profileImg,
        'role': userData.role.name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      SBHelperFunctions.showSuccessSnackbar("Your account has been created");
    } catch (error) {
      SBHelperFunctions.showErrorSnackbar("Something went wrong. Try again");
      print("CreateUser Error: $error");
    }
  }

  // fetch user data **(Optimized to use UID instead of querying by email)**
  Future<UserModel?> getUserDetails(String uid) async {
    try {
      final doc = await _db.collection("users").doc(uid).get();
      if (!doc.exists) {
        print("No user found with UID: $uid");
        return null;
      }
      return UserModel.fromSnapshot(doc);
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }

  // fetch all users (for admin)
  Future<List<UserModel>> getAllUserDetails() async {
    try {
      final snapshot = await _db.collection("users").get();
      return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    } catch (e) {
      print("Error fetching all users: $e");
      return [];
    }
  }
}
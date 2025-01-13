import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/repositories/user_repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // textfields controllers to get data from textfields
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final mobileNo = TextEditingController();

  // register user
  final authRepository = Get.put(AuthRepository());
  final userRepository = Get.put(UserRepository());


  // get email, password from user and pass it to register
  Future<void> registerUser(UserModel user) async {
    print("user $user");
    await authRepository.registerUserWithEmailAndPassword(user.email, user.password);

    User? currentUser = authRepository.firebaseUser.value;

    await userRepository.addUserToFirestore(currentUser,user);
  }
}
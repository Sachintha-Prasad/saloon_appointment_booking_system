import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/features/auth/auth_repository/auth_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // textfields controllers to get data from textfields
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final mobileNo = TextEditingController();

  void registerUser(String email, String password) {
    AuthRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}
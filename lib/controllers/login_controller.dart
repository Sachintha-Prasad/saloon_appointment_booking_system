import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  // textfields controllers to get data from textfields
  final email = TextEditingController();
  final password = TextEditingController();

  void logInUser(String email, String password) {
    AuthRepository.instance.logInWithEmailAndPassword(email, password);
  }
}
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();

  final _authRepository = Get.put(AuthRepository());

  void logoutUser(){
    _authRepository.logOut();
  }
}
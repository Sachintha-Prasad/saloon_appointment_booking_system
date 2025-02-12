import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final _authRepository = Get.put(AuthRepository());

  void logInUser(String email, String password) {
    _authRepository.logInWithEmailAndPassword(email, password);
  }
}
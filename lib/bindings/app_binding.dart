import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(AuthController());
  }
}
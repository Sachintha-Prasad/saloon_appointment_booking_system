import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';

class StylistController extends GetxController {
  @override
  void onInt() {
    super.onInit();
  }

  final ApiService apiService = Get.find<ApiService>();

  final RxBool isLoading = true.obs;
}
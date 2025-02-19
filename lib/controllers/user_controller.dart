import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  Rx<bool> isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    fetchUserData();
  }

  // fetch userdata from the storage
  Future<void> fetchUserData() async{
    final user = await StorageService.getUser();
    currentUser.value = user;
    isLoading.value = false;
  }
}
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/repositories/user_repository/user_repository.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _authRepository = Get.put(AuthRepository());
  final _userRepository = Get.put(UserRepository());

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // load user data when controller initializes
  }

  // fetch user data asynchronously
  Future<void> fetchUserData() async {
    try {
      final uid = _authRepository.firebaseUser.value?.uid;
      if (uid == null) {
        SBHelperFunctions.showErrorSnackbar("Login to continue!");
        return;
      }

      final userData = await _userRepository.getUserDetails(uid);
      currentUser.value = userData;
    } catch (error) {
      SBHelperFunctions.showErrorSnackbar("Failed to fetch user data.");
      print("Error fetching user data: $error");
    }
  }
}

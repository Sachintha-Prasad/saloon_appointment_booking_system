import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/auth_repository.dart';
import 'package:saloon_appointment_booking_system/repositories/user_repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // register user
  final _authRepository = Get.put(AuthRepository());
  final _userRepository = Get.put(UserRepository());

  // get email, password from user and pass it to register
  Future<void> registerUser(UserModel user, String password) async {
    // register user with Firebase Authentication
    await _authRepository.registerUserWithEmailAndPassword(user.email, password);

    // get the current user from Firebase Auth
    User? currentUser = _authRepository.firebaseUser.value;

    // add user to Firestore
    await _userRepository.addUserToFirestore(currentUser, user);
  }
}

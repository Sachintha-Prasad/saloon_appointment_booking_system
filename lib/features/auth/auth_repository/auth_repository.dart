import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/features/auth/auth_repository/exceptions/login_email_password_failure.dart';
import 'package:saloon_appointment_booking_system/features/auth/auth_repository/exceptions/register_email_password_failure.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/features/user/screens/user_dashboard/user_dashboard.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  // variables need to firebase
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const OnboardingScreen()) : Get.offAll(() => const UserDashboard());
  }

  // function for register
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const UserDashboard()) : Get.to(() => const OnboardingScreen());
    } on FirebaseAuthException catch(e) {
      final ex = RegisterWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch(_) {
      const ex = RegisterWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  // function for login
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      final ex = LogInWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch(_) {
      const ex = LogInWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  // function to logout
  Future<void> logOut() async => await _auth.signOut();
}
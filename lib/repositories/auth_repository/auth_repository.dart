import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/exceptions/login_email_password_failure.dart';
import 'package:saloon_appointment_booking_system/repositories/auth_repository/exceptions/register_email_password_failure.dart';
import 'package:saloon_appointment_booking_system/screens/auth/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/utils/helper/redirect_dashboard_function.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  // variables need to firebase
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  // firestore _db that points to firestore
  final _db = FirebaseFirestore.instance;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  // redirect the user to the dashboard according to their roles
  _setInitialScreen(User? user) async {
    print("currently logged user: $user");

    if (user == null) {
      Get.offAll(() => const OnboardingScreen());
    } else {
      final snapshot = await _db.collection("users").where("email", isEqualTo: user.email).get();
      if (snapshot.docs.isEmpty) {
        // Handle the case where no user is found
        print("No user found with the given email.");
        return;
      } else if (snapshot.docs.length > 1) {
        // Handle the case where more than one user is found (which shouldn't happen with unique email)
        print("Multiple users found with the same email.");
        return;
      } else {
        // Safely get the single user
        final userData = UserModel.fromSnapshot(snapshot.docs.first);
        SBRedirectToDashboard.getDashboardBasedOnRole(userData.role);
      }
    }
  }

  // function for register
  Future<void> registerUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
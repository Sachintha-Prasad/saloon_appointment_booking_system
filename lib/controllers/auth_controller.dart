import 'dart:convert';

import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/auth/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';
import 'package:saloon_appointment_booking_system/utils/helper/redirect_dashboard_function.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final ApiService _apiService = Get.put(ApiService());
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  // initially run autoLogin()
  void onInit(){
    super.onInit();
    autoLogin();
  }

  // handle auto login the user to keep user logged when app close
  Future<void> autoLogin() async {
    try{
      final responseData = await _apiService.authenticatedGet('auth/me');

      if(responseData.statusCode == 200) {
        final userData = jsonDecode(responseData.body);
        currentUser.value = UserModel.fromJson(userData);
        await StorageService.saveUser(currentUser.value as UserModel);
        SBRedirectToDashboard.getDashboardBasedOnRole(currentUser.value!.role);
      }
    } catch (err) {
        await StorageService.deleteToken();
        await StorageService.deleteUser();
        currentUser.value = null;
    }
  }

  // handle user register
  Future<void> register(UserModel user, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${_apiService.baseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'mobileNo': user.mobileNo,
          'password': password,
          'role': user.role.name,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        await _handleSuccessfulAuth(responseData);
      } else {
        SBCustomErrorHandler.handleErrorResponse(responseData, 'Registration failed');
      }
    } catch (err) {
      SBCustomErrorHandler.handleAuthError(err);
    }
  }

  // handle user login
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${_apiService.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await _handleSuccessfulAuth(responseData);
      } else {
        SBCustomErrorHandler.handleErrorResponse(responseData, 'Login failed');
      }
    } catch (err) {
      SBCustomErrorHandler.handleAuthError(err);
    }
  }

  // handle user logout
  Future<void> logout() async {
    await StorageService.deleteToken();
    await StorageService.deleteUser();
    currentUser.value = null;
    Get.offAll(() => const OnboardingScreen());
  }

  // this function use to save data to storage when successful user register or login
  Future<void> _handleSuccessfulAuth(Map<String, dynamic> responseData) async {
    final token = responseData['token'];
    final userData = responseData['user'];

    await StorageService.saveToken(token);
    final user = UserModel.fromJson(userData);
    await StorageService.saveUser(user);
    currentUser.value = user;


    SBRedirectToDashboard.getDashboardBasedOnRole(currentUser.value!.role);
  }
}
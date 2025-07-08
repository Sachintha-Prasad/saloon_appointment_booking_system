import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/auth/onboarding/onboarding_screen.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/services/secure_storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';
import 'package:saloon_appointment_booking_system/utils/helper/redirect_dashboard_function.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxBool isLoading = true.obs;
  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  

  // handle auto login the user to keep user logged when app close
  Future<void> autoLogin() async {
    try{
      final responseData = await _apiService.authenticatedGet('auth/me');

      if(responseData.statusCode == 200) {
        isLoading.value = false;
        final userData = jsonDecode(responseData.body);
        currentUser.value = UserModel.fromJson(userData);
        SBRedirectToDashboard.getDashboardBasedOnRole(currentUser.value!.role);
      } else {
        _handleAuthFailure();
      }
    } catch (err) {
        debugPrint('AutoLogin error: $err');
        _handleAuthFailure();
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
        SBCustomErrorHandler.handleErrorResponse(responseData, 'registration failed');
      }
    } catch (err) {
      SBCustomErrorHandler.handleAuthError(err);
    } finally {
      isLoading.value = false;
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
    await SecureStorageService.deleteToken();
    currentUser.value = null;
    Get.offAll(() => const OnboardingScreen());
  }

  // this function use to save data to storage when successful user register or login
  Future<void> _handleSuccessfulAuth(Map<String, dynamic> responseData) async {
    final token = responseData['token'];
    final userData = responseData['user'];

    await SecureStorageService.saveToken(token);
    final user = UserModel.fromJson(userData);
    currentUser.value = user;
    SBRedirectToDashboard.getDashboardBasedOnRole(currentUser.value!.role);
  }

  // function to handle autoLogin error or not user already logged
  void _handleAuthFailure() async {
    isLoading.value = false;
    await SecureStorageService.deleteToken();
    currentUser.value = null;
    Get.to(const OnboardingScreen());
  }
}
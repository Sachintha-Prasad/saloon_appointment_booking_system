import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';

class StylistController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final AuthController authController = Get.find<AuthController>();

  final RxBool isLoading = false.obs;
  final RxList<dynamic> upcomingAppointments = <dynamic>[].obs;
  final RxList<dynamic> appointmentRequests = <dynamic>[].obs;
  final RxList<dynamic> todaysAppointments = <dynamic>[].obs;
  final RxList<dynamic> leaves = <dynamic>[].obs;

  final RxBool isLeaveToday = false.obs;
  final RxInt upcomingAppointmentsCount = 0.obs;
  final RxInt todaysAppointmentsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final stylistId = authController.currentUser.value!.id;
    if (stylistId!.isNotEmpty) {
      fetchAllStylistData(stylistId);
    } else {
      debugPrint("Stylist ID is empty, cannot fetch stylist data.");
    }
  }

  // Fetch all stylist data
  Future<void> fetchAllStylistData(String stylistId) async {
    await Future.wait([
      fetchUpcomingAppointments(stylistId),
      fetchAppointmentRequests(stylistId),
      fetchAndCheckIfStylistOnLeaveToday(stylistId),
      fetchTodaysAppointments(stylistId),
    ]);
  }

  // Fetch upcoming appointments
  Future<void> fetchUpcomingAppointments(String stylistId) async {
    try {
      isLoading.value = true;
      final response = await apiService.authenticatedGet(
        "appointments/upcoming?stylistId=$stylistId",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['appointments'] ?? [];
        upcomingAppointments.assignAll(list);
        upcomingAppointmentsCount.value = list.length;
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch upcoming appointments");
      }
    } catch (e) {
      debugPrint("Error fetching upcoming appointments: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch today's appointments
  Future<void> fetchTodaysAppointments(String stylistId) async {
    try {
      isLoading.value = true;

      final response = await apiService.authenticatedGet(
        "appointments/today?stylistId=$stylistId",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['appointments'] ?? [];
        todaysAppointments.assignAll(list);
        todaysAppointmentsCount.value = list.length;
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch today's appointments");
      }
    } catch (e) {
      debugPrint("Error fetching today's appointments: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch appointment requests
  Future<void> fetchAppointmentRequests(String stylistId) async {
    try {
      isLoading.value = true;
      final response = await apiService.authenticatedGet(
        "appointments/requests?stylistId=$stylistId",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['requests'] ?? [];
        appointmentRequests.assignAll(list);
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch appointment requests");
      }
    } catch (e) {
      debugPrint("Error fetching appointment requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Apply stylist leave
  Future<void> applyStylistLeave({
    required String stylistId,
    required String date,
  }) async {
    try {
      isLoading.value = true;

      final body = {
        "stylistId": stylistId,
        "date": date,
      };

      final response = await apiService.authenticatedPost(
        "leaves",
        body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['leaves'] ?? [];
        leaves.assignAll(list);
        isLeaveToday.value = isStylistOnLeaveToday();
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to apply leave");
      }
    } catch (e) {
      debugPrint("Error applying leave: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch stylist leaves (current and upcoming)
  Future<void> fetchStylistLeaves(String stylistId) async {
    try {
      final response = await apiService.authenticatedGet(
        "leaves?stylistId=$stylistId",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['leaves'] ?? [];
        leaves.assignAll(list);
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch leaves");
      }
    } catch (e) {
      debugPrint("Error fetching leaves: $e");
    }
  }

  // Check if stylist is on leave today
  bool isStylistOnLeaveToday() {
    final today = DateTime.now();
    final todayString = "${today.year.toString().padLeft(4, '0')}-"
        "${today.month.toString().padLeft(2, '0')}-"
        "${today.day.toString().padLeft(2, '0')}";

    return leaves.any((leave) => leave['date'] == todayString);
  }

  // Fetch leaves and update isLeaveToday
  Future<void> fetchAndCheckIfStylistOnLeaveToday(String stylistId) async {
    await fetchStylistLeaves(stylistId);
    isLeaveToday.value = isStylistOnLeaveToday();
  }
}

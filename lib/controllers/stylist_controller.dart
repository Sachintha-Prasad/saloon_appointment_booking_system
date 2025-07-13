import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class StylistController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final AuthController authController = Get.find<AuthController>();

  final RxBool isLoading = false.obs;
  final RxList<dynamic> upcomingAppointments = <dynamic>[].obs;
  final RxList<dynamic> appointmentRequests = <dynamic>[].obs;
  final RxList<dynamic> todaysAppointments = <dynamic>[].obs;

  final RxInt upcomingAppointmentsCount = 0.obs;
  final RxInt todaysAppointmentsCount = 0.obs;
  final RxInt appointmentRequestsCount = 0.obs;


  @override
  void onInit() {
    super.onInit();
    final stylistId = authController.currentUser.value!.id;
    if (stylistId!.isNotEmpty) {
      fetchAllStylistData(stylistId);
    } else {
      SBHelperFunctions.showErrorSnackbar("stylistId not found");
    }
  }

  // Fetch all stylist data
  Future<void> fetchAllStylistData(String stylistId) async {
    await Future.wait([
      fetchUpcomingAppointments(stylistId),
      fetchAppointmentRequests(stylistId),
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
      debugPrint("Raw upcoming appointments: ${response.body}");

      final data = jsonDecode(response.body);

      if (data is List) {
        upcomingAppointments.assignAll(data);
        upcomingAppointmentsCount.value = data.length;
      } else {
        debugPrint("Unexpected upcoming appointments format: $data");
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
      debugPrint("Raw today's appointments: ${response.body}");

      final data = jsonDecode(response.body);

      if (data is List) {
        todaysAppointments.assignAll(data);
        todaysAppointmentsCount.value = data.length;
      } else {
        debugPrint("Unexpected today's appointments format: $data");
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
        "appointments/requested?stylistId=$stylistId",
      );
      debugPrint("Raw appointment requests: ${response.body}");

      final data = jsonDecode(response.body);

      if (data is List) {
        appointmentRequests.assignAll(data);
        appointmentRequestsCount.value = data.length;
      } else {
        debugPrint("Unexpected appointment requests format: $data");
      }
    } catch (e) {
      debugPrint("Error fetching appointment requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Accept appointment requests
  Future<void> acceptAppointment(String appointmentId) async {
    try {
      final response = await apiService.authenticatedPut(
        "appointments/$appointmentId/accept",
        {}, // no body needed
      );

      if (response.statusCode == 200) {
        await fetchAllStylistData(authController.currentUser.value!.id!);
        SBHelperFunctions.showSuccessSnackbar("Appointment accepted");
      } else {
        debugPrint("Accept failed: ${response.body}");
        SBHelperFunctions.showErrorSnackbar("Failed to accept appointment");
      }
    } catch (e) {
      debugPrint("Error accepting appointment: $e");
      SBHelperFunctions.showErrorSnackbar("Something went wrong");
    }
  }

  // Reject appointment requests
  Future<void> rejectAppointment(String appointmentId) async {
    try {
      final response = await apiService.authenticatedPut(
        "appointments/$appointmentId/reject",
        {}, // no body needed
      );

      if (response.statusCode == 200) {
        await fetchAllStylistData(authController.currentUser.value!.id!);
        SBHelperFunctions.showSuccessSnackbar("Appointment rejected");
      } else {
        debugPrint("Reject failed: ${response.body}");
        SBHelperFunctions.showErrorSnackbar("Failed to reject appointment");
      }
    } catch (e) {
      debugPrint("Error rejecting appointment: $e");
      SBHelperFunctions.showErrorSnackbar("Something went wrong");
    }
  }

}

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAvailableStylistList(SBHelperFunctions.convertDate(DateTime.now()));
  }

  final ApiService apiService = Get.find<ApiService>();

  final RxBool isLoading = true.obs;
  final RxBool isBookingAppointment = false.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxList<UserModel> stylistList = <UserModel>[].obs;
  final Rxn<UserModel> selectedStylist = Rxn<UserModel>();
  final RxList<int> availableSlots = <int>[].obs;
  final RxnInt selectedTimeSlot = RxnInt();

  // method to update the selected date and fetch available stylists
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    selectedTimeSlot.value = null;
    fetchAvailableStylistList(SBHelperFunctions.convertDate(date));
  }

  // fetch available stylist data
  Future<List<UserModel>> fetchAvailableStylistList(String date) async {
    try {
      isLoading.value = true;
      final responseData = await apiService
          .authenticatedGet("users/available-stylists?date=$date");

      if (responseData.statusCode == 200) {
        isLoading.value = false;
        final jsonResponse =
            jsonDecode(responseData.body) as Map<String, dynamic>;

        // extract the list using the correct key from API response
        final List<dynamic> jsonList = jsonResponse["availableStylists"] ?? [];

        final List<UserModel> stylistsList = jsonList
            .map((dynamic data) =>
                UserModel.fromJson(data as Map<String, dynamic>))
            .toList();
        stylistList.assignAll(stylistsList);

        // select the first stylist when date change
        if (stylistsList.isNotEmpty) {
          selectedStylist.value = stylistsList.first;
          fetchAvailableTimeSlots(date, selectedStylist.value!.id);
        }
        return stylistsList;
      } else {
        SBCustomErrorHandler.handleErrorResponse(
            responseData as Map<String, dynamic>, "error fetching data");
        return [];
      }
    } catch (err) {
      debugPrint("error fetching stylists: $err");
      return [];
    }
  }

  // fetch available time slots
  Future<void> fetchAvailableTimeSlots(String date, String? stylistId) async {
    if (stylistId == null) return;

    try {
      isLoading.value = true;
      final responseData = await apiService.authenticatedGet(
          "appointments/available-slots?stylistId=$stylistId&date=$date");

      if (responseData.statusCode == 200) {
        final jsonResponse =
            jsonDecode(responseData.body) as Map<String, dynamic>;

        final slots = List<int>.from(jsonResponse["availableSlots"] ?? []);

        availableSlots.assignAll(slots);
        // debugPrint("Available Slots: $availableSlots");
      } else {
        availableSlots.value = [];
        final errorResponse = jsonDecode(responseData.body);
        SBCustomErrorHandler.handleErrorResponse(
            errorResponse, "error fetching data");
      }
    } catch (err) {
      debugPrint("error fetching available time slots: $err");
      availableSlots.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  // select a time slot
  Future<void> selectTimeSlot(int slotNo) async {
    selectedTimeSlot.value = slotNo;
  }

  //  Create appointment
  Future<bool> createAppointment({
    required String clientId,
    required String stylistId,
    required String date,
    required int slotNumber,
  }) async {
    try {
      isBookingAppointment.value = true;

      final appointmentData = {
        "clientId": clientId,
        "stylistId": stylistId,
        "date": date,
        "slotNumber": slotNumber,
      };

      final responseData = await apiService.authenticatedPost(
        "appointments/",
        appointmentData,
      );

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        debugPrint("Appointment created successfully ");

        // Refresh available slots after successful booking
        await fetchAvailableTimeSlots(date, stylistId);

        return true;
      } else {
        final errorResponse = jsonDecode(responseData.body);
        SBCustomErrorHandler.handleErrorResponse(
          errorResponse,
          "Failed to create appointment",
        );
        return false;
      }
    } catch (err) {
      debugPrint("Error creating appointment: $err");
      return false;
    } finally {
      isBookingAppointment.value = false;
    }
  }
}

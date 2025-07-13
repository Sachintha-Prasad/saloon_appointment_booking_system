import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/utils/error_handlers/custom_error_handler.dart';

class LeaveController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final AuthController authController = Get.find<AuthController>();

  final RxBool isLoading = false.obs;
  final RxList<dynamic> leavesList = <dynamic>[].obs;
  final RxBool isLeaveToday = false.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  final RxList<DateTime> disabledDates = <DateTime>[].obs;

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  DateTime _parseDate(String dateStr) {
    final parts = dateStr.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  // Request stylist leave
  Future<void> requestStylistLeave({
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

        leavesList.assignAll(list);

        disabledDates.assignAll(
          list.map<DateTime>((e) => _parseDate(e['date'])).toList(),
        );

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

  // Fetch stylist leaves
  Future<void> fetchStylistLeaves(String stylistId) async {
    try {
      final response = await apiService.authenticatedGet(
        "leaves?stylistId=$stylistId",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> leaveDates = data['leaveDates'] ?? [];

        final formattedLeaves = leaveDates
            .map<Map<String, dynamic>>((dateStr) => {'date': dateStr.toString()})
            .toList();

        leavesList.assignAll(formattedLeaves);

        disabledDates.assignAll(
          formattedLeaves.map<DateTime>((e) => _parseDate(e['date'])).toList(),
        );
      } else {
        final error = jsonDecode(response.body);
        SBCustomErrorHandler.handleErrorResponse(error, "Failed to fetch leaves");
      }
    } catch (e) {
      debugPrint("Error fetching leaves: $e");
    }
  }

  bool isStylistOnLeaveToday() {
    final today = DateTime.now();
    final todayString = "${today.year.toString().padLeft(4, '0')}-"
        "${today.month.toString().padLeft(2, '0')}-"
        "${today.day.toString().padLeft(2, '0')}";

    return leavesList.any((leave) => leave['date'] == todayString);
  }
}

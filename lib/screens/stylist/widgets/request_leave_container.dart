import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/stylist_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_bottom_sheet.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class RequestLeaveContainer extends StatelessWidget {
  final StylistController stylistController;

  const RequestLeaveContainer({
    Key? key,
    required this.stylistController,
  }) : super(key: key);

  // ✅ Updated to async and waits for leave data before showing bottom sheet
  static Future<void> show({
    required StylistController stylistController,
  }) async {
    final userController = Get.put(UserController());
    userController.updateSelectedDate(DateTime.now());

    final stylistId = Get.find<AuthController>().currentUser.value?.id ?? '';
    if (stylistId.isEmpty) {
      Get.snackbar("Error", "User ID not found.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Wait for leaves to be fetched before showing the bottom sheet
    await stylistController.fetchStylistLeaves(stylistId);

    await CustomBottomSheet.show(
      child: RequestLeaveContainer(stylistController: stylistController),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userController = Get.find<UserController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Request Leave",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // 👇 Show loading indicator if fetching leaves
        Obx(() {
          if (stylistController.isLoading.value && stylistController.leaves.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final disabledDates = stylistController.leaves
              .map<DateTime>((leave) => DateTime.parse(leave['date'] ?? '1970-01-01'))
              .toList();

          return DatePicker(disabledDates: disabledDates);
        }),

        const SizedBox(height: 20),

        Obx(() {
          return CustomTextButton(
            btnText: stylistController.isLoading.value ? "Applying..." : "Apply Leave",
            btnType: ButtonType.primary,
            onPressed: stylistController.isLoading.value
                ? null
                : () async {
              final stylistId = authController.currentUser.value?.id ?? '';
              if (stylistId.isEmpty) {
                Get.snackbar("Error", "User ID not found.", snackPosition: SnackPosition.BOTTOM);
                return;
              }

              await stylistController.requestStylistLeave(
                stylistId: stylistId,
                date: SBHelperFunctions.convertDate(userController.selectedDate.value),
              );

              // 🔁 Fetch updated leave dates to reflect in UI
              await stylistController.fetchStylistLeaves(stylistId);

              if (!stylistController.isLoading.value) {
                Get.back();
                SBHelperFunctions.showSuccessSnackbar("Leave request submitted successfully!");
              }
            },
          );
        }),

        const SizedBox(height: 12),
      ],
    );
  }
}

class DatePicker extends StatelessWidget {
  final List<DateTime> disabledDates;

  const DatePicker({
    Key? key,
    this.disabledDates = const [],
  }) : super(key: key);

  bool _isDateDisabled(DateTime date) {
    return disabledDates.any((d) =>
    d.year == date.year && d.month == date.month && d.day == date.day);
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Column(
      children: [
        EasyTheme(
          data: EasyTheme.of(context).copyWith(
            currentDayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return SBColors.primary;
              if (states.contains(WidgetState.disabled)) return SBColors.grey;
              return Colors.transparent;
            }),
            currentDayBorder: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const BorderSide(color: SBColors.primary, width: SBSizes.borderWidth);
              } else if (states.contains(WidgetState.disabled)) {
                return const BorderSide(color: SBColors.grey, width: SBSizes.borderWidth);
              }
              return const BorderSide(color: Color(0x33757575), width: SBSizes.borderWidth);
            }),
            currentDayForegroundColor: const WidgetStatePropertyAll(SBColors.white),
            dayBorder: const WidgetStatePropertyAll(
              BorderSide(color: Color(0x33757575), width: SBSizes.borderWidth),
            ),
            overlayColor: const WidgetStatePropertyAll(Color(0x330083ac)),
          ),
          child: Obx(() => EasyDateTimeLinePicker(
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 6)),
            focusedDate: userController.selectedDate.value,
            currentDate: userController.selectedDate.value,
            onDateChange: (date) {
              if (_isDateDisabled(date)) return;
              userController.updateSelectedDate(date);
            },
            headerOptions: const HeaderOptions(headerType: HeaderType.none),
            timelineOptions: const TimelineOptions(padding: EdgeInsets.zero, height: 120.0),
          )),
        ),
      ],
    );
  }
}

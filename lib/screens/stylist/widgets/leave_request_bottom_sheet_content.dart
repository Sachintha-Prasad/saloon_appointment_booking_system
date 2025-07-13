import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/controllers/leave_controller.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class LeaveRequestBottomSheetContent extends StatelessWidget {
  LeaveRequestBottomSheetContent({super.key});

  final LeaveController leaveController = Get.put(LeaveController());
  final AuthController authController = Get.find<AuthController>();

  void _submitLeaveRequest() async {
    final selectedDate = leaveController.selectedDate.value;
    final stylistId = authController.currentUser.value?.id;

    if (stylistId == null) {
      SBHelperFunctions.showErrorSnackbar("Stylist not logged in");
      return;
    }

    final formattedDate = "${selectedDate.year.toString().padLeft(4, '0')}-"
        "${selectedDate.month.toString().padLeft(2, '0')}-"
        "${selectedDate.day.toString().padLeft(2, '0')}";

    await leaveController.requestStylistLeave(
      stylistId: stylistId,
      date: formattedDate,
    );

    SBHelperFunctions.showSuccessSnackbar("Your leave for $formattedDate has been submitted.");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SBSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Select Leave Date", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: SBSizes.spaceBtwItems),

            /// EasyDateTimeline Picker
            EasyTheme(
              data: EasyTheme.of(context).copyWith(
                currentDayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return SBColors.primary;
                  } else if (states.contains(WidgetState.disabled)) {
                    return SBColors.grey;
                  }
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
                    BorderSide(color: Color(0x33757575), width: SBSizes.borderWidth)),
                overlayColor: const WidgetStatePropertyAll(Color(0x330083ac)),
              ),
              child: EasyDateTimeLinePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                focusedDate: leaveController.selectedDate.value,
                currentDate: leaveController.selectedDate.value,
                onDateChange: leaveController.updateSelectedDate,
                headerOptions: const HeaderOptions(headerType: HeaderType.none),
                timelineOptions: const TimelineOptions(
                  padding: EdgeInsets.zero,
                  height: 110.0,
                ),
                disableStrategy: DisableStrategy.list(
                  leaveController.leavesList.map((leave) => DateTime.parse(leave['date'])).toList(),
                ),
              ),
            ),

            const SizedBox(height: SBSizes.spaceBtwSections),

            leaveController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : CustomTextButton(
              btnText: "Submit Leave",
              prefixIcon: const Icon(Icons.send),
              onPressed: _submitLeaveRequest,
            ),
          ],
        ),
      ),
    ));
  }
}

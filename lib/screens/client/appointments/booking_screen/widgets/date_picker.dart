import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Column(
      children: [
        EasyTheme(
            data: EasyTheme.of(context).copyWith(
              currentDayBackgroundColor:
              WidgetStateProperty.resolveWith((states) {
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
                  BorderSide(color: Color(0x33757575), width: SBSizes.borderWidth)
              ),

              overlayColor: const WidgetStatePropertyAll(
                  Color(0x330083ac)
              ),
            ),

            child: Obx(() => EasyDateTimeLinePicker(
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 6)),
              focusedDate: userController.selectedDate.value,
              currentDate: userController.selectedDate.value,
              onDateChange: (date) {
                userController.updateSelectedDate(date);
              },
              headerOptions:
              const HeaderOptions(headerType: HeaderType.none),
              timelineOptions: const TimelineOptions(
                  padding: EdgeInsets.zero, height: 120.0),
            ), )
        ),
      ],
    );
  }
}
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class AppointmentBookingScreen extends StatelessWidget {
  const AppointmentBookingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> stylistsList = ['Stylist A', 'Stylist B', 'Stylist C', 'Stylist D'];

    return SingleChildScrollView(
        child: Padding(
          padding: SBSpacingStyle.paddingMainLayout.add(const EdgeInsets.only(top: 12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose your stylist',
                  style: Theme.of(context).textTheme.headlineSmall),
               const SizedBox(height: SBSizes.spaceBtwItems),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stylistsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 180,
                        height: 60,
                        color: SBColors.darkGrey,
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: SBColors.primary,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: SBSizes.spaceBtwSections),


              Text('Choose your appointment date',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: SBSizes.spaceBtwItems),
              EasyTheme(
                data: EasyTheme.of(context).copyWith(
                    currentDayBackgroundColor:
                    WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return SBColors.primary;
                      } else if (states.contains(WidgetState.disabled)) {
                        return SBColors.grey;
                      }
                      return SBColors.white;
                    }),
                    overlayColor: const WidgetStatePropertyAll(
                        Color(0x330083ac)
                    ),
                    currentDayBorder: const WidgetStatePropertyAll(
                      BorderSide(color: SBColors.primary),
                    ),
                    currentDayForegroundColor: const WidgetStatePropertyAll(SBColors.white)),

                child: EasyDateTimeLinePicker(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 6)),
                  focusedDate: DateTime.now(),
                  onDateChange: (date) {
                    // Handle the selected date.
                  },
                  headerOptions:
                  const HeaderOptions(headerType: HeaderType.none),
                  timelineOptions: const TimelineOptions(
                      padding: EdgeInsets.zero, height: 120.0),
                ),
              ),
            ],
          ),
        )
    );
  }
}
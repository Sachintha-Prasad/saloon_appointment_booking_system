import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/empty_placeholder.dart';
import 'package:saloon_appointment_booking_system/common/widgets/section_title.dart';
import 'package:saloon_appointment_booking_system/controllers/user_controller.dart';
import 'package:saloon_appointment_booking_system/data/time_slots/time_slots_data.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/widgets/date_picker.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/widgets/stylist_card.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/widgets/time_slot_card_skeleton.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppointmentBookingScreen extends StatelessWidget {
  const AppointmentBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    final selectedDate =
        SBHelperFunctions.convertDate(userController.selectedDate.value);

    return SingleChildScrollView(
      child: Padding(
        padding: SBSpacingStyle.paddingMainLayout
            .add(const EdgeInsets.only(top: 12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker ===================================================================
            const SectionTitle(title: 'Choose your appointment date'),
            const SizedBox(height: SBSizes.spaceBtwItems),
            const DatePicker(),
            const SizedBox(height: SBSizes.spaceBtwSections),

            // Available Stylist List ========================================================
            const SectionTitle(title: "Available stylist"),
            const SizedBox(height: SBSizes.spaceBtwItems),

            Obx(() {
              final List<UserModel> stylistsList = userController.stylistList;
              final selectedStylist = userController.selectedStylist.value;

              return SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stylistsList.length,
                  itemBuilder: (context, index) {
                    final stylist = stylistsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: StylistCard(
                        stylist: stylist,
                        isSelected: selectedStylist?.id == stylist.id,
                        onTap: () {
                          userController.selectedStylist.value = stylist;
                          userController.selectedTimeSlot.value = null;
                          userController.fetchAvailableTimeSlots(selectedDate,
                              userController.selectedStylist.value!.id);
                        },
                      ),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: SBSizes.spaceBtwSections),

            // Available Time Slots ==========================================================
            const SectionTitle(title: "Available time slots"),
            const SizedBox(height: SBSizes.spaceBtwItems),

            Obx(() {
              final selectedStylist = userController.selectedStylist.value;
              // debugPrint("Selected Stylist: ${userController.availableSlots}");

              if (selectedStylist == null) {
                return const EmptyPlaceholder(
                    placeholderText: "Select a stylist to see slots");
              }

              final availableSlots = userController.availableSlots;
              final selectedSlot = userController.selectedTimeSlot.value;

              if (availableSlots.isEmpty) {
                return const EmptyPlaceholder(
                    placeholderText: "No slots available");
              }

              return Skeletonizer(
                enabled: userController.isLoading.value,
                child: ListView.builder(
                  itemCount: TimeSlotsData.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final slot = TimeSlotsData.data[index];
                    final slotNo = slot['slotNo'];
                    final isAvailable = availableSlots.contains(slotNo);
                    final isSelected = selectedSlot == slotNo;

                    return userController.isLoading.value
                        ? const TimeSlotCardSkeleton()
                        : GestureDetector(
                            onTap: isAvailable
                                ? () => userController.selectTimeSlot(slotNo)
                                : null,
                            child: Opacity(
                              opacity: isAvailable ? 1.0 : 0.5,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isAvailable
                                      ? SBColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isAvailable
                                        ? SBColors.primary
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${slot['startTime']} - ${slot['endTime']}',
                                      style: TextStyle(
                                        color: isAvailable
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (isSelected && isAvailable)
                                      const Icon(Icons.check_circle,
                                          color: Colors.white),
                                    if (!isAvailable)
                                      const Icon(Icons.lock,
                                          color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/empty_placeholder.dart';
import 'package:saloon_appointment_booking_system/common/widgets/section_title.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
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

// Show confirmation bottom sheet when a time slot is selected
  void _showConfirmationBottomSheet(
      BuildContext context, UserController userController, int slotNo) {
    final bool isDarkMode = SBHelperFunctions.isDarkMode(context);
    final slot = TimeSlotsData.data.firstWhere((s) => s['slotNo'] == slotNo);
    final selectedStylist = userController.selectedStylist.value;
    final selectedDate =
        SBHelperFunctions.convertDate(userController.selectedDate.value);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF1E1E1E)
              : SBColors.darkModeInactiveSlotBgColor, // Dark background
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600], // Darker handle bar
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SBColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.schedule,
                    color: SBColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Confirm Appointment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? SBColors.white
                        : SBColors.primary, // White text for dark theme
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Appointment Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF2A2A2A)
                    : SBColors.white, // Dark card background
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isDarkMode
                        ? Colors.grey[700]!
                        : SBColors.primary), // Darker border
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                      icon: Icons.person,
                      label: 'Stylist',
                      value: selectedStylist?.name ?? 'Unknown',
                      isDarkMode: isDarkMode),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: selectedDate,
                      isDarkMode: isDarkMode),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: '${slot['startTime']} - ${slot['endTime']}',
                      isDarkMode: isDarkMode),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side:
                          BorderSide(color: Colors.grey[600]!), // Darker border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() => ElevatedButton(
                        onPressed: userController.isBookingAppointment.value
                            ? null
                            : () async {
                                // Get the current user ID from AuthController
                                final AuthController authController =
                                    Get.find<AuthController>();
                                final clientId =
                                    authController.currentUser.value?.id;

                                if (clientId == null) {
                                  Get.snackbar(
                                    'Error',
                                    'User not logged in. Please login again.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderRadius: 12,
                                    margin: const EdgeInsets.all(16),
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    duration: const Duration(seconds: 3),
                                  );
                                  return;
                                }

                                final success =
                                    await userController.createAppointment(
                                  clientId: clientId,
                                  stylistId: selectedStylist!.id!,
                                  date: SBHelperFunctions.convertDate(
                                      userController.selectedDate.value),
                                  slotNumber: slotNo,
                                );

                                if (success) {
                                  // Close the bottom sheet
                                  Navigator.pop(context);
                                  // Show success message
                                  SBHelperFunctions.showDarkSnackbar(
                                      'Appointment booked successfully!');

                                  // Update selected time slot
                                  userController.selectTimeSlot(slotNo);
                                } else {
                                  // Show error message
                                  Get.snackbar(
                                    'Error',
                                    'Failed to book appointment. Please try again.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderRadius: 12,
                                    margin: const EdgeInsets.all(16),
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    duration: const Duration(seconds: 3),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SBColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: userController.isBookingAppointment.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text(
                                'Confirm',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      )),
                ),
              ],
            ),

            // Bottom safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

//Helper method to build detail rows in the confirmation card
  Widget _buildDetailRow(
      {required IconData icon,
      required String label,
      required String value,
      required bool isDarkMode}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: SBColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.grey[400] : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    final selectedDate =
        SBHelperFunctions.convertDate(userController.selectedDate.value);

    const Color activeSlotColor = SBColors.primary;
    const Color inactiveSlotBgColor = Color.fromARGB(47, 218, 246, 255);
    const Color inactiveSlotTextColor = Color.fromARGB(148, 255, 255, 255);

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

                    final bool isDarkMode =
                        SBHelperFunctions.isDarkMode(context);

                    return userController.isLoading.value
                        ? const TimeSlotCardSkeleton()
                        : GestureDetector(
                            onTap: isAvailable
                                ? () => _showConfirmationBottomSheet(
                                    context, userController, slotNo)
                                : null, // Disable tap for unavailable slots
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isAvailable
                                    ? activeSlotColor
                                    : (isDarkMode
                                        ? inactiveSlotBgColor
                                        : SBColors.darkModeInactiveSlotBgColor),
                                borderRadius: BorderRadius.circular(12),
                                border: isAvailable
                                    ? Border.all(color: activeSlotColor)
                                    : Border.all(
                                        color: isDarkMode
                                            ? inactiveSlotTextColor
                                            : SBColors
                                                .darkModeInactiveSlotTextColor),
                                boxShadow: isAvailable
                                    ? [
                                        BoxShadow(
                                          color:
                                              activeSlotColor.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : (isDarkMode
                                        ? [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            ),
                                          ]
                                        : null),
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
                                          : (isDarkMode
                                              ? inactiveSlotTextColor // Add this color to your SBColors class
                                              : SBColors
                                                  .darkModeInactiveSlotTextColor),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // if (isSelected && isAvailable)
                                  //   const Icon(Icons.check_circle,
                                  //       color: Colors.white),
                                  if (!isAvailable)
                                    Icon(Icons.block,
                                        color: isDarkMode
                                            ? SBColors
                                                .darkModeInactiveSlotTextColor // Add this color to your SBColors class
                                            : SBColors
                                                .darkModeInactiveSlotTextColor),
                                ],
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

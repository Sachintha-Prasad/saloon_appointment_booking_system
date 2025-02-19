import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/controllers/services_controller.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/widgets/service_card.dart';
import 'package:saloon_appointment_booking_system/screens/client/home/widgets/service_card_skelton.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ClientServices extends StatelessWidget {
  const ClientServices({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicesController servicesController = Get.put(ServicesController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Our services', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: SBSizes.md),

        SizedBox(
          height: 220.0,
          child: Obx(() {
            return Skeletonizer(
              enabled: servicesController.isLoading.value,
              child: GridView.builder(
                itemCount: servicesController.isLoading.value
                    ? 2
                    : servicesController.servicesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  if (servicesController.isLoading.value) {
                    return const ServiceCardSkeleton();
                  }
                  final service = servicesController.servicesList[index];
                  return ServiceCard(service: service);
                },
              ),
            );
          }),
        ),
        const SizedBox(height: SBSizes.defaultSpace),

        CustomTextButton(
          btnText: "Book an Appointment",
          onPressed: () => {},
        ),
      ],
    );
  }
}
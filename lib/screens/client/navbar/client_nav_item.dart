import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/controllers/client_dashboard_navigation_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class ClientNavItem extends StatelessWidget {
  const ClientNavItem({
    super.key,
    required this.icon,
    required this.index,
  });

  final IconData icon;
  final int index;


  @override
  Widget build(BuildContext context) {
    final ClientDashboardNavigationController navigationController = Get.put(ClientDashboardNavigationController());
    
    return Obx(
            () => GestureDetector(
              onTap: () => navigationController.selectedIndex.value = index,
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: navigationController.selectedIndex.value == index
                        ? SBColors.primary
                        : SBColors.darkGrey,
                    size: SBSizes.iconXl,
                  ),
                  const SizedBox(height: SBSizes.sm),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: navigationController.selectedIndex.value == index ? 6 : 0,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: navigationController.selectedIndex.value == index
                          ? SBColors.primary
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
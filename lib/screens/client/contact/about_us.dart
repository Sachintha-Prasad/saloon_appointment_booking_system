import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome to Salon Blue, where style meets precision! We are more than just a barbershop, we’re a space where men can relax, refresh, and redefine their look. Our skilled barbers specialize in classic cuts, modern styles, beard grooming, and hot towel shaves, ensuring you leave looking sharp and feeling confident.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: SBSizes.spaceBtwSections),

        Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(SBSizes.borderRadiusLg),
                child: Image.asset(SBImages.clientAboutImage, width: double.infinity, fit: BoxFit.cover,)
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SBSizes.borderRadiusMd),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                    color: SBColors.primary.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: SBColors.white),
                            const SizedBox(width: SBSizes.defaultSpace),
                            Text("Pambahinna, Belihuloya", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: SBColors.white),)
                          ],
                        ),
                        const SizedBox(height: SBSizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.phone, color: SBColors.white),
                            const SizedBox(width: SBSizes.defaultSpace),
                            Text("077 1212234", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: SBColors.white),)
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:saloon_appointment_booking_system/utils/constants/image_strings.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class ClientDashboardCarousel extends StatelessWidget {
  const ClientDashboardCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // image carousel array
    final List<String> images = [
      SBImages.clientCarouselImg1,
      SBImages.clientCarouselImg2,
      SBImages.clientCarouselImg3
    ];

    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: 180.0,
        showIndicator: false,
        // slideIndicator: SequentialFillIndicator(),
        autoPlay: true,
        viewportFraction: 1.0,
        pauseAutoPlayOnTouch: true,
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SBSizes.borderRadiusLg),
                child: Image.asset(
                  i,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
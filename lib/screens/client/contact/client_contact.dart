import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/screens/client/contact/about_us.dart';

class ClientContact extends StatelessWidget {
  const ClientContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("About us", style: Theme.of(context).textTheme.headlineSmall),
      ),

      body: const SingleChildScrollView(
        child: Padding(
            padding: SBSpacingStyle.paddingMainLayout,
            child: Column(
              children: [
                // about us===============================================================================
                AboutUs()
              ],
            ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/tabs/appointment_booking_screen.dart';
import 'package:saloon_appointment_booking_system/screens/client/appointments/booking_screen/tabs/pending_page.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class ClientAppointmentScreen extends StatelessWidget {
  const ClientAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Appointments",
                style: Theme.of(context).textTheme.headlineSmall),
            bottom: TabBar(
              tabs: const [
                Tab(
                  text: "Book now",
                ),
                Tab(text: "Pending"),
                Tab(text: "Approved")
              ],
              labelStyle: GoogleFonts.nunitoSans(
                  fontSize: SBSizes.fontSizeSm, fontWeight: FontWeight.w600),
              labelColor: SBColors.primary,
              indicatorColor: SBColors.primary,
              overlayColor: const WidgetStatePropertyAll(Color(0x330083ac)),
            ),
          ),
          body: TabBarView(
            children: [
              const AppointmentBookingScreen(),
              const AppointmentPendingTab(), // <- Add pending tab
              Container(), // Approved tab placeholder
            ],
          )),
    );
  }
}

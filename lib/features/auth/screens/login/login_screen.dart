import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/common/widgets/auth_divider.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/common/widgets/auth_header.dart';
import 'package:saloon_appointment_booking_system/features/auth/lib/auth_header_data.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/login/login_footer.dart';
import 'package:saloon_appointment_booking_system/features/auth/screens/login/login_form.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  @override
  Widget build(BuildContext context) {
    final isDark = SBHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SBSpacingStyle.paddingAuthLayout,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header=======================================================================================
              AuthHeader(authHeaderData: logInHeaderData),
              const SizedBox(height: SBSizes.spaceBtwSections),

              Column(
                children: [
                  // form section================================================================================
                  const LogInForm(),
                  const SizedBox(height: SBSizes.md),

                  // divider=======================================================================================
                  AuthDivider(isDark: isDark),
                  const SizedBox(height: SBSizes.md),

                  // footer section===============================================================================
                  const LogInFooter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





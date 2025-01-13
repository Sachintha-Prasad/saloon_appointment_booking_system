import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/data/auth/auth_header_data.dart';
import 'package:saloon_appointment_booking_system/screens/auth/common/widgets/auth_divider.dart';
import 'package:saloon_appointment_booking_system/screens/auth/common/widgets/auth_header.dart';
import 'package:saloon_appointment_booking_system/screens/auth/register/widgets/register_footer.dart';
import 'package:saloon_appointment_booking_system/screens/auth/register/widgets/register_form.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    final isDark = SBHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SBSpacingStyle.paddingAuthLayout,
          child: Column(
            children: [
              // header=======================================================================================
              AuthHeader(authHeaderData: registerHeaderData,),
              const SizedBox(height: SBSizes.spaceBtwSections),

              Column(
                children: [
                  // form section================================================================================
                  const RegisterForm(),
                  const SizedBox(height: SBSizes.md),

                  // divider=======================================================================================
                  AuthDivider(isDark: isDark),
                  const SizedBox(height: SBSizes.md),

                  // footer section===============================================================================
                  RegisterFooter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





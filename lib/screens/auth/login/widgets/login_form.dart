import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_form_field.dart';
import 'package:saloon_appointment_booking_system/controllers/login_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // logIn controller
    final logInController = Get.put(LogInController());
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: SizedBox(
        height: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // form
            Column(
              children: [
                // email
                CustomTextFormField(
                  hintText: "Email",
                  obscureText: false,
                  controller: logInController.email,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // password
                CustomTextFormField(
                  hintText: "Password",
                  obscureText: true,
                  controller: logInController.password,
                  prefixIcon: Icons.lock_outlined,
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // forgot password button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: ()=> print('clicked forgot password'), child: Text("Forgot password?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: SBColors.primary),)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: SBSizes.spaceBtwSections),

            // action button
            Column(
              children: [
                CustomTextButton(
                    btnText: 'Log In',
                    onPressed: () => {
                      if(_formKey.currentState!.validate()){
                        LogInController.instance.logInUser(
                          logInController.email.text.trim(),
                          logInController.password.text.trim()
                        )
                      }
                    },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
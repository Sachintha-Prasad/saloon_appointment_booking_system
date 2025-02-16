import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_form_field.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';
import 'package:saloon_appointment_booking_system/utils/constants/regex.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();

    // text-fields controllers to get data from text-fields
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
      key: formKey,
      child: SizedBox(
        height: 440.0,
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
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!SBRegEx.emailRegEx.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // password
                CustomTextFormField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: Icons.lock_outlined,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'Password is required';
                    }
                    return null;
                  },
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
                      if(formKey.currentState!.validate()){
                      authController.login(
                          emailController.text.trim(),
                          passwordController.text.trim()
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
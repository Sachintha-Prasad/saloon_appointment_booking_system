import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_form_field.dart';
import 'package:saloon_appointment_booking_system/controllers/auth_controller.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/regex.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final formKey = GlobalKey<FormState>();

    // text-fields controllers to get data from text-fields
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final mobileNoController = TextEditingController();

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
                // name
                CustomTextFormField(
                  hintText: "Name",
                  controller: nameController,
                  obscureText: false,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // email
                CustomTextFormField(
                  hintText: "Email",
                  controller: emailController,
                  obscureText: false,
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

                // mobile number
                CustomTextFormField(
                  hintText: "Mobile number",
                  controller: mobileNoController,
                  obscureText: false,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mobile number is required';
                    }
                    if (!SBRegEx.mobileNoRegEx.hasMatch(value)) {
                      return 'Enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // password
                CustomTextFormField(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: SBSizes.spaceBtwInputFields),

            // action button
            Column(
              children: [
                CustomTextButton(
                  btnText: 'Join Now',
                  onPressed: () {
                    final user = UserModel(
                        email: emailController.text.trim(),
                        name: nameController.text.trim(),
                        mobileNo: mobileNoController.text.trim(),
                        role: Roles.client,
                    );

                    final password =  passwordController.text.trim();

                    authController.register(user, password);
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
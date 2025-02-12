import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_form_field.dart';
import 'package:saloon_appointment_booking_system/controllers/register_controller.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // register controller
    final registerController = Get.put(RegisterController());
    final formKey = GlobalKey<FormState>();

    // textfields controllers to get data from textfields
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final mobileNoController = TextEditingController();

    return Form(
      key: formKey,
      child: SizedBox(
        height: 400.0,
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
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // email
                CustomTextFormField(
                  hintText: "Email",
                  controller: emailController,
                  obscureText: false,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // mobile number
                CustomTextFormField(
                  hintText: "Mobile number",
                  controller: mobileNoController,
                  obscureText: false,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),

                // password
                CustomTextFormField(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outlined,
                ),
                const SizedBox(height: SBSizes.spaceBtwInputFields),
              ],
            ),
            const SizedBox(height: SBSizes.spaceBtwSections),

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
                        role: Roles.CLIENT,
                    );

                    final password =  passwordController.text.trim();

                    registerController.registerUser(user, password);
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
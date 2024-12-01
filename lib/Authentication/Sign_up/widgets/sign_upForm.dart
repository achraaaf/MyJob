import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/Sign_up/Controller/SignUpController.dart';
import 'package:flutter_application_1/Authentication/Sign_up/widgets/TextFieldForm.dart';
import 'package:flutter_application_1/Authentication/login.dart';
import 'package:flutter_application_1/utils/validators/SignUpValidation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  final SelectedUserTypeScreen;
  const SignUpForm({super.key, required this.SelectedUserTypeScreen});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    controller.selectedUserType = SelectedUserTypeScreen;
    return Form(
      key: controller.signupFormkey,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: 10),
          // ========= Full Name =========
          TextFieldForm(
              hintText: "Full Name",
              prefixIcon: Iconsax.user,
              obsecuretext: false,
              controller: controller.Name,
              validationCallback: (value) => Validation.ValidateName(value)),
          SizedBox(height: 15),
          // ========= Email =========
          TextFieldForm(
              hintText: "Your Email",
              prefixIcon: Iconsax.sms_tracking,
              obsecuretext: false,
              controller: controller.Email,
              validationCallback: (value) => Validation.ValidateEmail(
                  value, controller.isAlreadyUsed.value)),
          SizedBox(height: 15),
          Obx(
            () => TextFieldForm(
                hintText: "Password",
                prefixIcon: Iconsax.password_check,
                sufixIcon: Iconsax.eye_slash,
                obsecuretext: controller.hidePassword.value,
                controller: controller.Password,
                validationCallback: (value) =>
                    Validation.ValidatePassword(value),
                hideShowPassword: () => controller.hidePassword.value =
                    !controller.hidePassword.value),
          ),
          SizedBox(height: 15),
          Obx(
            () => TextFieldForm(
                hintText: "Confirm Password",
                prefixIcon: Iconsax.password_check,
                sufixIcon: Iconsax.eye_slash,
                obsecuretext: controller.hidePassword.value,
                controller: controller.ConfirmPassword,
                validationCallback: (value) =>
                    Validation.ValidateConfirmPassword(
                        value, controller.Password.text),
                hideShowPassword: () => controller.hidePassword.value =
                    !controller.hidePassword.value),
          ),

          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already an account ? ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: const Color.fromARGB(255, 99, 99, 99),
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          /// Sign Up Button
          SignupButton(context, () => controller.signup(context)),
        ],
      ),
    );
  }

  Row SignupButton(BuildContext context, covariant void Function() onPressed) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            height: 60,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                onPressed();
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

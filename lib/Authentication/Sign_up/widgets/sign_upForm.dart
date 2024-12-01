import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/Authentication/Controller/AuthController.dart';
import 'package:MyJob/Authentication/Login/view/LoginScreen.dart';
import 'package:MyJob/Authentication/Sign_up/widgets/TextFieldForm.dart';
import 'package:MyJob/utils/validators/SignUpValidation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatefulWidget {
  final BuildContext parentContext;
  final SelectedUserTypeScreen;
  const SignUpForm(
      {super.key,
      required this.SelectedUserTypeScreen,
      required this.parentContext});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    controller.selectedUserType = widget.SelectedUserTypeScreen;

    return Form(
      key: signupFormkey,
      child: Obx(() {
        return Column(
          children: [
            SizedBox(height: 10),
            // ========= Nom complet =========
            TextFieldForm(
                hintText: widget.SelectedUserTypeScreen == "employer"
                    ? "Nom de l'entreprise"
                    : "Nom complet",
                prefixIcon: Iconsax.user,
                obsecuretext: false,
                controller: controller.Name,
                validationCallback: (value) => Validation.ValidateName(value)),
            SizedBox(height: 15),
            // ========= Email =========
            TextFieldForm(
                hintText: "Votre Email",
                prefixIcon: Iconsax.sms_tracking,
                obsecuretext: false,
                controller: controller.Email,
                validationCallback: (value) => Validation.ValidateEmail(value)),
            SizedBox(height: 15),
            TextFieldForm(
                hintText: "Mot de passe",
                prefixIcon: Iconsax.password_check,
                sufixIcon: Iconsax.eye_slash,
                obsecuretext: controller.hidePassword.value,
                controller: controller.Password,
                validationCallback: (value) =>
                    Validation.ValidatePassword(value),
                hideShowPassword: () => controller.hidePassword.value =
                    !controller.hidePassword.value),

            SizedBox(height: 15),
            TextFieldForm(
                hintText: "Confirmer le mot de passe",
                prefixIcon: Iconsax.password_check,
                sufixIcon: Iconsax.eye_slash,
                obsecuretext: controller.hidePassword.value,
                controller: controller.ConfirmPassword,
                validationCallback: (value) =>
                    Validation.ValidateConfirmPassword(
                        value, controller.Password.text),
                hideShowPassword: () => controller.hidePassword.value =
                    !controller.hidePassword.value),

            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Déjà un compte ? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: const Color.fromARGB(255, 99, 99, 99),
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'Connexion',
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
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            /// Bouton S'inscrire
            SignupButton(context,
                () => controller.signup(widget.parentContext, signupFormkey)),
          ],
        );
      }),
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
                if (!signupFormkey.currentState!.validate()) {
                  return;
                }
                onPressed();
              },
              child: Text(
                'S\'inscrire',
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

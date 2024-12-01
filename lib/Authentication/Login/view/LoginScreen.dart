import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/Authentication/Controller/AuthController.dart';
import 'package:MyJob/Authentication/SelectedUserTypeScreen.dart';
import 'package:MyJob/Authentication/SignIn_Up.dart';
import 'package:MyJob/Authentication/Sign_up/widgets/TextFieldForm.dart';
import 'package:MyJob/utils/validators/SignUpValidation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(AuthController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight, child: signin_up()));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Align(
                alignment: Alignment.topRight,
                child: Image(image: AssetImage("images/Star.png"))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Obx(() {
              if (controller.isLoading.value) {
                return SizedBox(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: [
                      Lottie.asset("images/loadinganimation.json"),
                      Text(
                        "Connexion...",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "  Bienvenue!",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.30,
                        ),
                      ),
                      Image(
                        image: AssetImage("images/Hi.png"),
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "  Connectez-vous,",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 0.04,
                      letterSpacing: -0.30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "  Connectons-vous!",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF9BA7B2),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.10,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFieldForm(
                      hintText: "Votre Email",
                      prefixIcon: Iconsax.sms_tracking,
                      obsecuretext: false,
                      controller: controller.Email,
                      validationCallback: (value) =>
                          Validation.ValidateEmail(value)),
                  SizedBox(height: 15),
                  Text(
                    "Mot de passe",
                    style: TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
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
                  SizedBox(height: 40),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        controller.login(context, formKey);
                      },
                      child: Text(
                        "Connexion",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.05,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Vous n\'avez pas de compte ? ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: const Color.fromARGB(255, 99, 99, 99),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: 'S\'inscrire',
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
                                    builder: (context) =>
                                        SelectedUserTypeScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

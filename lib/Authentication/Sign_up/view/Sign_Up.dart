import 'package:flutter/material.dart';
import 'package:MyJob/Authentication/Controller/AuthController.dart';
import 'package:MyJob/Authentication/SignIn_Up.dart';
import 'package:MyJob/Authentication/Sign_up/widgets/sign_upForm.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SignUpScreen extends StatelessWidget {
  final SelectedUserTypeScreen;
  const SignUpScreen({super.key, required this.SelectedUserTypeScreen});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  children: [
                    Lottie.asset("images/loadinganimation.json"),
                    Text(
                      "Inscription en cours...",
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
                      "  Salut, toi! ",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 30,
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
                SizedBox(height: 30),
                Text(
                  "  Créer un compte,",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 0.04,
                    letterSpacing: -0.30,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "  Inscrivez-vous pour commencer!",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF9BA7B2),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.10,
                  ),
                ),
                SizedBox(height: 30),
                SignUpForm(
                  SelectedUserTypeScreen: SelectedUserTypeScreen,
                  parentContext: context,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

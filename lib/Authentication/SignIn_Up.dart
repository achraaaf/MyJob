import 'package:flutter/material.dart';
import 'package:MyJob/Authentication/Login/view/LoginScreen.dart';
import 'package:MyJob/Authentication/SelectedUserTypeScreen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class signin_up extends StatelessWidget {
  const signin_up({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: Lottie.asset("images/SignUpIn.json")),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text("Bienvenue à",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  Text(
                    "My Job!",
                    style: TextStyle(
                        color: Color(0xFFED4546),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                  Text(
                    "  Découvrez les opportunités de carrière. Que vous recherchiez des défis ou que vous embauchiez, nous avons ce qu'il vous faut. Choisissez ci-dessous pour commencer!",
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 139, 139, 139),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => SelectedUserTypeScreen());
                          },
                          child: Text(
                            "S'inscrire",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.10,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            side: BorderSide(
                                color: Color(0xFF343434), width: 0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => LoginScreen());
                          },
                          child: Text(
                            "S'identifier",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.10,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(
                                  color: Color(0xFF343434), width: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 13)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

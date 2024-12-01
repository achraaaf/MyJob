import 'package:flutter/material.dart';
import 'package:MyJob/Authentication/SignIn_Up.dart';
import 'package:MyJob/Authentication/Sign_up/view/Sign_Up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SelectedUserTypeScreen extends StatefulWidget {
  const SelectedUserTypeScreen({Key? key});

  @override
  State<SelectedUserTypeScreen> createState() => _SelectedUserTypeScreenState();
}

class _SelectedUserTypeScreenState extends State<SelectedUserTypeScreen> {
  String? selectedUserType;
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
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Align(
                alignment: Alignment.topRight,
                child: Image(image: AssetImage("images/Star.png"))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 19),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 180,
                child: Image(
                  image: AssetImage("images/selectusertype.png"),
                ),
              ),
              Text(
                'Choisissez votre type d\'emploi',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Choisissez si vous cherchez un emploi ou si vous êtes une organisation/entreprise ayant besoin d\'employés',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF585858),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedUserType = 'employer';
                        });
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: selectedUserType == 'employer'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: selectedUserType == 'employer'
                                ? Colors.white
                                : Color.fromARGB(255, 209, 209, 209),
                            width: 0.7,
                          ),
                          // ------ For showdow -------
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(1, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/employer2.png',
                              height: 50,
                              color: selectedUserType == 'employer'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Employeur',
                              style: GoogleFonts.ubuntu(
                                  color: selectedUserType == 'employer'
                                      ? Colors.white
                                      : Color.fromARGB(255, 36, 34, 34),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Je veux trouver des employés",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ubuntu(
                                    color: selectedUserType == 'employer'
                                        ? Colors.white
                                        : Color.fromARGB(255, 36, 34, 34),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 5),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedUserType = 'job_seeker';
                        });
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: selectedUserType == 'job_seeker'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: selectedUserType == 'job_seeker'
                                ? Colors.white
                                : Color.fromARGB(255, 209, 209, 209),
                            width: 0.7,
                          ),
                          // ------ For showdow -------
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(1, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/job-seeker3.png',
                              height: 50,
                              color: selectedUserType == 'job_seeker'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Employe',
                              style: GoogleFonts.ubuntu(
                                  color: selectedUserType == 'job_seeker'
                                      ? Colors.white
                                      : Color.fromARGB(255, 36, 34, 34),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Je veux trouver un emploi pour moi",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ubuntu(
                                    color: selectedUserType == 'job_seeker'
                                        ? Colors.white
                                        : Color.fromARGB(255, 36, 34, 34),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedUserType != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                                SelectedUserTypeScreen: selectedUserType),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Continuer',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

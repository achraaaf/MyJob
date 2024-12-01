import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/SignIn_Up.dart';
import 'package:flutter_application_1/Authentication/Sign_up.dart';
import 'package:flutter_application_1/Authentication/Sign_up/Sign_Up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SelectedUserTypeScreen extends StatefulWidget {
  const SelectedUserTypeScreen({super.key});

  @override
  State<SelectedUserTypeScreen> createState() => _SelectedUserTypeScreenState();
}

class _SelectedUserTypeScreenState extends State<SelectedUserTypeScreen> {
  String? selectedUserType;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.only(left: 15),
              icon: Image(image: AssetImage("images/left-arrow.png")),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: signin_up()));
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 19),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Image(
                        image: AssetImage("images/selectusertype.png"),
                      ),
                    ),
                    Text(
                      'Choose your job type',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        'Choose whether you are looking for a job or you are an orgaonization/company that need employees',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF585858),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedUserType = 'employer';
                              });
                            },
                            child: Container(
                              height: 200.h,
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
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 20, // Blur radius
                                    offset: Offset(3, 5),
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
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Employer',
                                    style: GoogleFonts.ubuntu(
                                        color: selectedUserType == 'employer'
                                            ? Colors.white
                                            : Color.fromARGB(255, 36, 34, 34),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 15.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "I want to find employees",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ubuntu(
                                          color: selectedUserType == 'employer'
                                              ? Colors.white
                                              : Color.fromARGB(255, 36, 34, 34),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                        SizedBox(width: 5.w),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedUserType = 'job_seeker';
                              });
                            },
                            child: Container(
                              height: 200.h,
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
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 20, // Blur radius
                                    offset: Offset(3, 5),
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
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Job seeker',
                                    style: GoogleFonts.ubuntu(
                                        color: selectedUserType == 'job_seeker'
                                            ? Colors.white
                                            : Color.fromARGB(255, 36, 34, 34),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 15.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "I want to find a job for me",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ubuntu(
                                          color: selectedUserType ==
                                                  'job_seeker'
                                              ? Colors.white
                                              : Color.fromARGB(255, 36, 34, 34),
                                          fontSize: 15.sp,
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
                        height: 60.h,
                        width: MediaQuery.of(context).size.width * 0.9,
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
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/SelectedUserTypeScreen.dart';
import 'package:flutter_application_1/Authentication/Sign_up.dart';
import 'package:flutter_application_1/Authentication/Sign_up/Sign_Up.dart';
import 'package:flutter_application_1/Authentication/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class signin_up extends StatelessWidget {
  const signin_up({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 12.w),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child:
                                  Image(image: AssetImage("images/login.png"))),
                          Text(
                            "Welcom to",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp),
                          ),
                          Text(
                            "My Job!",
                            style: TextStyle(
                                color: Color(0xFFED4546),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "  Discover career opportunities. Whether you're seeking challenges or hiring, we've got you covered. Choose below to begin!",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF9BA7B2),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              height: 60.h,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  primary: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              height: 55.h,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectedUserTypeScreen()),
                                  );
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  primary: const Color(0xFFAFAFAF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}

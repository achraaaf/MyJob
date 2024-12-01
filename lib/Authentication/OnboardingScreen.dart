import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/SignIn_Up.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("images/get_started_img.png"),
                ),
                SizedBox(
                  height: 18,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Find Your\n",
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "Dream ",
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "Job",
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.red,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "!",
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Find your perfect job match and take your career to new heights ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF808080),
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 55,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      final storage = GetStorage();
                      storage.write('isFirstTime', false);

                      // Navigate to the second page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signin_up()),
                      );
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

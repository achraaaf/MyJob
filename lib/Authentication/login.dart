import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/SelectedUserTypeScreen.dart';
import 'package:flutter_application_1/Authentication/SignIn_Up.dart';
import 'package:flutter_application_1/employer_screens/Employer_Home.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _submitForm() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      emailErrorMessage = '';
      passwordErrorMessage = '';
    });

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // get the uid
        String uid = userCredential.user?.uid ?? '';

        Future<String> GetUserType(String uid) async {
          try {
            var employerQuery = await FirebaseFirestore.instance
                .collection('employers')
                .where('uid', isEqualTo: uid)
                .get();
            if (employerQuery.docs.isNotEmpty) {
              return 'employer';
            }
            var jobSeekerQuery = await FirebaseFirestore.instance
                .collection('Job_seekers')
                .where('uid', isEqualTo: uid)
                .get();

            if (jobSeekerQuery.docs.isNotEmpty) {
              return 'job_seeker';
            }

            return 'error';
          } catch (e) {
            return 'error';
          }
        }

        GetUserType(uid).then((String userType) {
          if (userType == 'employer') {
            //HiveServices.fetchDataandStoreinHive(uid, userType);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => employer_HomeScreen()),
            );
          } else if (userType == 'job_seeker') {
            //HiveServices.fetchDataandStoreinHive(uid, userType);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarJobseekerApp()));
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            emailErrorMessage = 'No user found with this email.';
          });
        } else if (e.code == 'wrong-password') {
          setState(() {
            passwordErrorMessage = 'Incorrect password.';
          });
        } else {
          setState(() {
            passwordErrorMessage = 'Incorrect password.';
          });
        }
      } catch (e) {
        print(
            '==============================================Unexpected error during sign-in: $e');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool pwVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                ]),
            body: LayoutBuilder(builder: (context, constraints) {
              return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "  Welcome back!",
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
                                height: 35.h,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "  Sign in,",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    height: 0.04,
                                    letterSpacing: -0.30,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "  Let's sign you in!",
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF9BA7B2),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              //--------------------------------
                              // -------------Email-------------
                              // -------------------------------
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.025),
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.black
                                        .withOpacity(0.10000000149011612),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email.';
                                      }
                                      if (emailErrorMessage.isNotEmpty) {
                                        return emailErrorMessage;
                                      }
                                      return null;
                                    },
                                    controller: _emailController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      errorStyle: const TextStyle(height: 0),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        top: size.height * 0.025,
                                      ),
                                      hintText: 'Your Email',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Futura',
                                        color: Color(0xFF3B3B3B),
                                      ),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.015,
                                        ),
                                        child: Icon(
                                          Icons.email_outlined,
                                          color: const Color(0xff7B6F72),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //--------------------------------
                              // ------------Password-----------
                              // -------------------------------
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.025),
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.black
                                        .withOpacity(0.10000000149011612),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password.';
                                      }
                                      if (passwordErrorMessage.isNotEmpty) {
                                        return passwordErrorMessage;
                                      }
                                      return null;
                                    },
                                    controller: _passwordController,
                                    obscureText: !pwVisible,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      errorStyle: const TextStyle(height: 1),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        top: size.height * 0.025,
                                      ),
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Futura',
                                        color: Color(0xFF3B3B3B),
                                      ),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.015,
                                        ),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: const Color(0xff7B6F72),
                                        ),
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.015,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              pwVisible = !pwVisible;
                                            });
                                          },
                                          child: pwVisible
                                              ? const Icon(
                                                  Icons.visibility_off_outlined,
                                                  color: Color(0xff7B6F72),
                                                )
                                              : const Icon(
                                                  Icons.visibility_outlined,
                                                  color: Color(0xff7B6F72),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 30.h,
                                width: MediaQuery.of(context).size.width * 0.6,
                                //child: Divider(),
                              ),

                              // Social Media login

                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 167,
                                              167, 167), // Border color
                                          width: 1.0, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Border radius
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Image(
                                          image:
                                              AssetImage('images/search.png'),
                                          height: 30.h,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 167,
                                              167, 167), // Border color
                                          width: 1.0, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Border radius
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Image(
                                          image:
                                              AssetImage('images/facebook.png'),
                                          height: 30.h,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 167,
                                              167, 167), // Border color
                                          width: 1.0, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Border radius
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Image(
                                          image:
                                              AssetImage('images/linkedin.png'),
                                          height: 30.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Dont have an account ? ',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: const Color.fromARGB(
                                            255, 99, 99, 99),
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Register',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
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
                              SizedBox(
                                height: 5.h,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  height: 60.h,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _submitForm();
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
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                      primary:
                                          const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
          ),
        );
      },
    );
  }
}

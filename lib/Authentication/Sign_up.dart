import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/User_Model.dart';
import 'package:flutter_application_1/Authentication/Auth_Repository/User_Repository.dart';
import 'package:flutter_application_1/Authentication/SelectedUserTypeScreen.dart';
import 'package:flutter_application_1/employer_screens/Employer_Home.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:flutter_application_1/Authentication/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sign_up extends StatefulWidget {
  final String? selectedUserType;

  Sign_up(this.selectedUserType);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final _formKey = GlobalKey<FormState>();

  bool pwVisible = false;
  bool pwVisibleConfirm = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool userTypeNotSelected = false;

  //  ========= For errors messages ==============
  String emailErrorMessage = '';
  String passwordErrorMessage = '';
  // ============ end ===================

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _submitForm() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      emailErrorMessage = '';
      passwordErrorMessage = '';
    });

    if (_formKey.currentState!.validate() && widget.selectedUserType != null) {
      String userType = widget.selectedUserType as String;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String uid = userCredential.user?.uid ?? '';

        final user = UserModel(
          id: uid,
          email: _emailController.text,
          name: _nameController.text,
          role: userType,
        );
        final UserRepo = Get.put(UserRepository());
        await UserRepo.createUser(user);

        // Navigate based on user role
        if (user.role == 'job_seeker') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigationBarJobseekerApp(),
            ),
          );
        } else if (user.role == 'employer') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => employer_HomeScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            emailErrorMessage =
                'Email is already in use. Please use a different email.';
          });
        } else if (e.code == 'invalid-email') {
          setState(() {
            emailErrorMessage = 'Please enter a valid email address.';
          });
        } else if (e.code == 'weak-password') {
          setState(() {
            passwordErrorMessage =
                'Weak password. Please use a stronger password.';
          });
        } else {
          print("==========================================");
          print('Error during sign-upp: ${e.message}');
          print("==========================================");
          print("error code :  ${e.code}");
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

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
                          child: SelectedUserTypeScreen()));
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "  Hi, There!",
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
                        SizedBox(
                          height: 35.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "  Create Account,",
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
                            "  Sign up to get started!",
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
                        //-------------------------------
                        // -----------Full Name---------
                        // ------------------------------
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Container(
                            width: size.width * 0.9,
                            height: 60,
                            decoration: BoxDecoration(
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Full name';
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                hintText: 'Full Name',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Futura',
                                  color: Color(0xFF3B3B3B),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.005,
                                  ),
                                  child: Icon(
                                    Icons.person_outlined,
                                    color: const Color(0xff7B6F72),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // -----------------------------
                        // ----------- email -----------
                        // -----------------------------
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
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
                                  top: size.height * 0.02,
                                ),
                                hintText: 'Your Email',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Futura',
                                  color: Color(0xFF3B3B3B),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.005,
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
                        //-----------------------------------
                        // ------------- Password -----------
                        //-----------------------------------
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Paswword';
                                }
                                if (passwordErrorMessage.isNotEmpty) {
                                  return passwordErrorMessage;
                                }
                                return null;
                              },
                              obscureText: !pwVisible,
                              controller: _passwordController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                // Handle password value change if needed
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Futura',
                                  color: Color(0xFF3B3B3B),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.01,
                                  ),
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: const Color(0xff7B6F72),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.010,
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
                        // -------------------------------------
                        // --------- Confirm Password ----------
                        // -------------------------------------

                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              controller: _confirmpasswordController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscureText: !pwVisibleConfirm,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                hintText: 'Confirm password',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Futura',
                                  color: Color(0xFF3B3B3B),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.01,
                                  ),
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: const Color(0xff7B6F72),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.01,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        pwVisibleConfirm = !pwVisibleConfirm;
                                      });
                                    },
                                    child: pwVisibleConfirm
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
                        //Spacer(),
                        SizedBox(
                          height: 30.h,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already an account ? ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: const Color.fromARGB(255, 99, 99, 99),
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: 'Login',
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
                                        builder: (context) => Login(),
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text(
                                'Sign up',
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

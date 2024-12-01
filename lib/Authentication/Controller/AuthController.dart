import 'package:MyJob/Authentication/EmployerSetup/view/SetupView.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/Models/User_Model.dart';
import 'package:MyJob/employer_screens/Employer_Home.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final UserRepo = Get.put(UserRepository());

  RxBool wrongPassword = false.obs;

  //varibales
  late String? selectedUserType;
  final hidePassword = true.obs;
  final Name = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();
  final ConfirmPassword = TextEditingController();

  RxBool isLoading = false.obs;

  signup(BuildContext context, GlobalKey<FormState> signupFormkey) async {
    try {
      isLoading.value = true;

      // Form validation
      if (!signupFormkey.currentState!.validate() && selectedUserType == null) {
        return;
      }

      // create user on firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email.text,
        password: Password.text,
      );

      String uid = userCredential.user?.uid ?? '';
      String userType = selectedUserType as String;
      // create User Model
      final user = UserModel(
        id: uid,
        email: Email.text,
        name: Name.text,
        role: userType,
      );
      // Create user in Firestore
      await UserRepo.createUser(user);
      // redirect to home page
      if (user.role == 'job_seeker') {
        Get.put(JobSeekerController()).fetchJobSeekersRecord();

        Name.clear();
        Email.clear();
        Password.clear();
        ConfirmPassword.clear();
        await Future.delayed(const Duration(seconds: 2));

        Get.offAll((() => BottomNavigationBarJobseeker()));
      } else if (user.role == 'employer') {
        Get.put(EmployerController()).fetchEmployerRecord();
        Name.clear();
        Email.clear();
        Password.clear();
        ConfirmPassword.clear();
        await Future.delayed(const Duration(seconds: 2));

        Get.offAll(() => SetupView());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "Email already in use",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Something went wrong, Please try again",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  login(BuildContext context, GlobalKey<FormState> loginFormkey) async {
    try {
      isLoading.value = true;

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email.text,
        password: Password.text,
      );

      String uid = userCredential.user?.uid ?? '';

      final UserType = await UserRepo.getUserType(uid);

      if (UserType == 'job_seeker') {
        final jobSeekerData = Get.put(JobSeekerController());
        await jobSeekerData.fetchJobSeekersRecord();
        Email.clear();
        Password.clear();
        await Future.delayed(const Duration(seconds: 2));

        Get.offAll((() => BottomNavigationBarJobseeker()));
      } else if (UserType == 'employer') {
        Get.put(EmployerController()).fetchEmployerRecord();
        Email.clear();
        Password.clear();

        await Future.delayed(const Duration(seconds: 2));

        Get.offAll(() => employer_HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        isLoading.value = false;
        wrongPassword.value = true;
        Get.snackbar("Error", "Password is incorrect",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Email or Password is incorrect",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }
}

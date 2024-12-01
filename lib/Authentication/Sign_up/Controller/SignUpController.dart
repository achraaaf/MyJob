import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/Auth_Repository/User_Repository.dart';
import 'package:flutter_application_1/Models/User_Model.dart';
import 'package:flutter_application_1/employer_screens/Employer_Home.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  var isAlreadyUsed = false.obs;

  //varibales
  late String? selectedUserType;
  final hidePassword = true.obs;
  final Name = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();
  final ConfirmPassword = TextEditingController();
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    Name.dispose();
    Email.dispose();
    Password.dispose();
    ConfirmPassword.dispose();
  }

  signup(BuildContext context) async {
    try {
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
      final UserRepo = Get.put(UserRepository());
      await UserRepo.createUser(user);
      // redirect to home page
      if (user.role == 'job_seeker') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigationBarJobseekerApp()),
        );
      } else if (user.role == 'employer') {
        Get.offAll(employer_HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        isAlreadyUsed.value = true;
      }
    }
  }
}

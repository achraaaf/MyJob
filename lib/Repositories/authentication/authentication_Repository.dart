import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Authentication/OnboardingScreen.dart';
import 'package:flutter_application_1/Authentication/SignIn_Up.dart';
import 'package:flutter_application_1/Repositories/user/User_Repository.dart';
import 'package:flutter_application_1/employer_screens/Employer_Home.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final currentUser = _auth.currentUser;

    print("====================== $currentUser =======================");

    if (currentUser != null) {
      late String userType;

      final userDocument = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      if (userDocument.exists) {
        userType = userDocument.data()!['role'].toString();
        print("==================== $userType =======================");
      }

      if (userType == 'job_seeker') {
        Get.offAll(() => BottomNavigationBarJobseeker());
      } else if (userType == 'employer') {
        Get.offAll(() => employer_HomeScreen());
      }
    } else {
      // Local storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll((() => signin_up()))
          : Get.offAll(() => OnboardingScreen());
    }
  }

  User? get authUser => _auth.currentUser;

  Future<UserCredential> registerwithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw "Something went wrong";
    }
  }
}

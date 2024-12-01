import 'package:flutter_application_1/Models/Job_seeker/Job_seeker.dart';
import 'package:flutter_application_1/Authentication/Auth_Repository/User_Repository.dart';
import 'package:flutter_application_1/Authentication/Auth_Repository/authentication_Repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  
}

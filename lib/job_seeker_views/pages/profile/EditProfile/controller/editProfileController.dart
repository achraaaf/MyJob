import 'package:flutter/material.dart';
import 'package:flutter_application_1/Repositories/user/User_Repository.dart';
import 'package:flutter_application_1/Controllers/JobSeekerController.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class editProfileController extends GetxController {
  static editProfileController get instance => Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController DateBirthday = TextEditingController();

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  final userRepo = UserRepository.Instance;
  final JobSeekerData = JobSeekerController.instance;

  SaveChanges(BuildContext context , GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Map<String, dynamic> data = {
      'name': nameController.text,
      'city': cityController.text,
    };
    userRepo.updatesinglefield(data);
    userRepo.updateOnUserCollection(data);

    JobSeekerData.jobSeeker.value.name = nameController.text;
    JobSeekerData.jobSeeker.value.city = cityController.text;

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            child: BottomNavigationBarJobseeker(wantedPage: 4)));
  }
}

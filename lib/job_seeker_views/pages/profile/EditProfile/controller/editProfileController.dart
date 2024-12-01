import 'package:flutter/material.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:get/get.dart';

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

  SaveChanges(BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    userRepo.updatesinglefield("Job_seekers", {
      'name': nameController.text,
      'city': cityController.text,
      'phone': phoneController.text,
    });
    userRepo.updateOnUserCollection({
      'name': nameController.text,
      'city': cityController.text,
    });

    JobSeekerData.jobSeeker.value.name = nameController.text;
    JobSeekerData.jobSeeker.value.city = cityController.text;
    JobSeekerData.jobSeeker.value.phone = phoneController.text;

  }
}

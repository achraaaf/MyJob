import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/Employer_Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class editProfileController extends GetxController {
  static editProfileController get instance => Get.find();

  TextEditingController companyName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController companyLogo = TextEditingController();
  TextEditingController Industry = TextEditingController();
  TextEditingController companySize = TextEditingController();
  TextEditingController companyDescription = TextEditingController();

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  final userRepo = UserRepository.Instance;
  final EmployerData = EmployerController.instance;

  SaveChanges(BuildContext context) async {
    if (!editProfileFormKey.currentState!.validate()) {
      return;
    }

    userRepo.updatesinglefield("employers", {
      'companyName': companyName.text,
      'city': city.text,
      'companySize': companySize.text,
      'description': companyDescription.text,
      'industry': Industry.text
    });
    userRepo.updateOnUserCollection({
      'name': companyName.text,
      'city': city.text,
    });

    EmployerData.employer.value.companyName = companyName.text;
    EmployerData.employer.value.city = city.text;
    EmployerData.employer.value.companySize = companySize.text;
    EmployerData.employer.value.description = companyDescription.text;
    EmployerData.employer.value.Industry = Industry.text;
    Get.off(() => employer_HomeScreen(wantedPage: 4));
  }
}

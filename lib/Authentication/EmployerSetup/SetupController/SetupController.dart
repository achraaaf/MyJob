import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:get/get.dart';

class SetupController extends GetxController {
  static SetupController get instance => Get.find();

  // variables
  RxString SelectedIndustry = "Technology IT".obs;
  RxString SelectedCCompanySize = "1 - 10 Employees".obs;
  RxString description = "".obs;

  final userRepo = UserRepository.Instance;
  final employerController = EmployerController.instance;

  void storeData() async {
    await userRepo.updatesinglefield("employers", {
      'industry': SelectedIndustry.value,
      'companySize': SelectedCCompanySize.value,
      'description': description.value
    });
    employerController.employer.value.companySize = SelectedCCompanySize.value;
    employerController.employer.value.Industry = SelectedIndustry.value;
    employerController.employer.value.description = description.value;
  }
}

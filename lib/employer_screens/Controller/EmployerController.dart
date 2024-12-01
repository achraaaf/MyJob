
import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EmployerController extends GetxController {
  static EmployerController get instance => Get.find();

  Rx<Employer> employer = Employer.emptyEmployer().obs;

  final userRepo = Get.put(UserRepository());
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployerRecord();
  }

  Future<void> fetchEmployerRecord() async {
    try {
      isLoading.value = true;
      final employer = await userRepo.getEmployerData();

      if (employer != this.employer.value) {
        this.employer(employer);
      }
    } catch (e) {
      Employer.emptyEmployer();
    } finally {
      isLoading.value = false;
    }
  }

  uploadUserProfilePicture() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512);
    if (image != null) {
      final imageUrl =
          await userRepo.uploadimage('User/Images/Profile/', image);

      // update user record
      Map<String, dynamic> json = {'companyLogo': imageUrl};

      await userRepo.updatesinglefield("employers",json);

      employer.value.CompanyLogo = imageUrl;
      employer.refresh();
    }
  }

}


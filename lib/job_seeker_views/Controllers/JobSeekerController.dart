import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class JobSeekerController extends GetxController {
  static JobSeekerController get instance => Get.find();

  Rx<Job_seeker> jobSeeker = Job_seeker.emptyJobseeker().obs;
  final userRepo = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchJobSeekersRecord();
  }

  Future<void> fetchJobSeekersRecord() async {
    try {
      final jobSeeker = await userRepo.getJobSeekerData();
      
      if (jobSeeker != this.jobSeeker.value) {
        this.jobSeeker(jobSeeker);
      }
    } catch (e) {
      Job_seeker.emptyJobseeker();
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
      Map<String, dynamic> json = {'picture': imageUrl};

      await userRepo.updatesinglefield(json);

      jobSeeker.value.profilePicture = imageUrl;
      jobSeeker.refresh();
    }
  }
}

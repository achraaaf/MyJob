import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:get/get.dart';

class SearchJobSeekersController extends GetxController {
  static SearchJobSeekersController get instance => Get.find();

  // variables
  RxBool isLoading = false.obs;

  final userRepo = UserRepository.Instance;

  List<Job_seeker> JobSeekers = [];
  RxList<Job_seeker> FiltredjobSeekers = <Job_seeker>[].obs;

  @override
  void onInit() {
    super.onInit();

    FetchJobSeekers();
  }

  void FetchJobSeekers() async {
    try {
      isLoading.value = true;
      final Data = await userRepo.getJobSeekersList();
      JobSeekers = Data;
      FiltredjobSeekers.value = JobSeekers;
    } finally {
      isLoading.value = false;
    }
  }

  void SearchJobSeekers(String Keyword) {
    final lowerCaseQuery = Keyword.toLowerCase();

    FiltredjobSeekers.value = JobSeekers.where((jobSeeker) =>
            jobSeeker.name.toLowerCase().contains(lowerCaseQuery) ||
            jobSeeker.skills
                .any((skill) => skill.toLowerCase().contains(lowerCaseQuery)))
        .toList();
  }
}

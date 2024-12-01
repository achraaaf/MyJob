import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Models/jobApplication/JobApplication.dart';
import 'package:MyJob/Repositories/JobPost/JobPostsRepository.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/Repositories/jobapplication/JobApplicationRepostory.dart';
import 'package:get/get.dart';

class JobApplicationsController extends GetxController {
  static JobApplicationsController get instance => Get.find();

  //variables
  final jobApplicationRepo = Get.put(JobApplicationRepostory());
  final jobPostRepo = JobPostsRepository.instance;
  final JobSeekerID = AuthenticationRepository.instance;
  RxBool isLoading = false.obs;

  final List<JobApplication> jobApplications = <JobApplication>[].obs;
  final List<JobPostModel> jobPostApplications = <JobPostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobApplications();
  }

  void fetchJobApplications() async {
    try {

      // start loader
      isLoading.value = true;

      final jobApplicationsList = await jobApplicationRepo
          .fetchJobAplications(JobSeekerID.authUser!.uid);

      jobApplications.assignAll(jobApplicationsList);

      for (var jobApp in jobApplications) {
        final post = await jobPostRepo.GetJobPostById(jobApp.JobPostId);
        if (!jobPostApplications
            .any((existingPost) => existingPost.id == post.id)) {
          jobPostApplications.add(post);
        }
      }
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }
}

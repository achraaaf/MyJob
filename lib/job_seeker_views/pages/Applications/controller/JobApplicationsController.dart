import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/Models/Job_seeker/jobApplication/JobApplication.dart';
import 'package:flutter_application_1/Repositories/JobPost/JobPostsRepository.dart';
import 'package:flutter_application_1/Repositories/authentication/authentication_Repository.dart';
import 'package:flutter_application_1/Repositories/jobapplication/JobApplicationRepostory.dart';
import 'package:get/get.dart';

class JobApplicationsController extends GetxController {
  static JobApplicationsController get instance => Get.find();

  //variables
  final jobApplicationRepo = Get.put(JobApplicationRepostory());
  final jobPostRepo = JobPostsRepository.instance;
  final JobSeekerID = AuthenticationRepository.instance;

  final List<JobApplication> jobApplications = <JobApplication>[].obs;
  final List<JobPostModel> jobPostApplications = <JobPostModel>[].obs;

  @override
  void onInit() {
    fetchJobApplications();
    GetJobPostsDetails();
    super.onInit();
  }

  void fetchJobApplications() async {
    final jobApplicationsList =
        await jobApplicationRepo.fetchJobAplications(JobSeekerID.authUser!.uid);

    jobApplications.assignAll(jobApplicationsList);
  }

  void GetJobPostsDetails() async {
    print("============ im here ============");
    for (var jobApp in jobApplications) {
      final post = await jobPostRepo.GetJobPostById(jobApp.JobPostId);
      jobPostApplications.add(post);
    }
  }
}

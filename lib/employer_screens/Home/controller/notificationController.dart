import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/Models/jobApplication/JobApplication.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class notificationsController extends GetxController {
  static notificationsController get instance => Get.find();
  //variables
  RxBool isLoading = false.obs;
  final UserRepo = UserRepository.Instance;

  Future<Job_seeker> fetchJobSeekerDetails(String JobSeekerId) async {
    var jobSeeker = Job_seeker.emptyJobseeker();
    try {
      isLoading.value = true;
      jobSeeker = await UserRepo.getJobSeekerDataById(JobSeekerId);
    } finally {
      isLoading.value = false;
      return jobSeeker;
    }
  }

  Future<JobApplication> fetchJobApplicationDetails(String applicatinId) async {
    var jobApplication = JobApplication.EmptyJobApplication();
    try {
      isLoading.value = true;

      final snapshot = await FirebaseFirestore.instance
          .collection("applicationJobs")
          .doc(applicatinId)
          .get();

      jobApplication = JobApplication.fromSnapshot(snapshot);
    } finally {
      isLoading.value = false;
      return jobApplication;
    }
  }

  Future<JobPostModel> fetchJobPostDetails(String JobPostId) async {
    var jobPost = JobPostModel.EmptyJobPostModel();

    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection("job_posts")
          .doc(JobPostId)
          .get();

      jobPost = JobPostModel.fromSnapshot(snapshot);
    } finally {
      isLoading.value = false;
      return jobPost;
    }
  }
}

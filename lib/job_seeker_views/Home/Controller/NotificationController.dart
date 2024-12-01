import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Models/jobApplication/JobApplication.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationsControllerJ extends GetxController {
  static NotificationsControllerJ get instance => Get.find();

  //variables
  RxBool isLoading = false.obs;

  final UserRepo = UserRepository.Instance;

  Future<Employer> fetchEmployerDetails(String JobSeekerId) async {
    var employer = Employer.emptyEmployer();
    try {
      isLoading.value = true;
      employer = await UserRepo.getEmployerDataById(JobSeekerId);
    } finally {
      isLoading.value = false;
      return employer;
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

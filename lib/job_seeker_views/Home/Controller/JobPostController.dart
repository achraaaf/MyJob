import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/Repositories/JobPost/JobPostsRepository.dart';
import 'package:get/get.dart';

class JobPostController extends GetxController {
  static JobPostController get instance => Get.find();
  final JobPostRepo = Get.put(JobPostsRepository());

  RxList<JobPostModel> jobPostsList = <JobPostModel>[].obs;

  @override
  void onInit() {
    fetchJobPosts();
    super.onInit();
  }

  void fetchJobPosts() async {
    // fetch job posts from repository
    final JobPosts = await JobPostRepo.GetJobPosts();
  
    // store the job posts in the RxList
    jobPostsList.assignAll(JobPosts);
  }

  // see deitails of the job post

  // save the job post
  
  

}

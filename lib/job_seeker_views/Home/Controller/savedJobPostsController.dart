import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/Helper/loaders.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/Repositories/JobPost/SavedJobPostRepository.dart';
import 'package:get/get.dart';

class savedJobPostsController extends GetxController {
  static savedJobPostsController get instance => Get.find();

  final authRepo = AuthenticationRepository.instance;
  final JobSeekerData = JobSeekerController.instance;
  final savedJobsRepo = Get.put(savedJobPostRepository());

  final savedJobPosts = <JobPostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSavedJobPosts();
  }

  void getSavedJobPosts() async {
    List<JobPostModel> savedposts = await savedJobsRepo.GetSavedJobPosts();

    savedJobPosts.assignAll(savedposts);
  }

  toggleSavedJobPost(JobPostModel jobPost, BuildContext context) {
    bool isSaved =
        savedJobPosts.any((post) => post.jobLocation == jobPost.jobLocation);

    if (isSaved) {
      savedJobsRepo.removeJobPost(jobPost);
      savedJobPosts
          .removeWhere((post) => post.jobLocation == jobPost.jobLocation);
      print(savedJobPosts.length);

      // update the rx jobseeker data
      savedJobPosts
          .removeWhere((post) => post.jobLocation == jobPost.jobLocation);

      // show a toast
      loaders.CustomToast(message: "Job post removed from saved jobs.");
    } else {
      savedJobsRepo.saveJobPost(jobPost);
      // update the rx jobseeker data
      savedJobPosts.add(jobPost);

      // show a toast
      loaders.CustomToast(message: "Job post saved successfully!");
    }
  }

  Widget getIconForSavedJobs(JobPostModel jobPost) {
    bool isSaved =
        savedJobPosts.any((post) => post.jobLocation == jobPost.jobLocation);

    if (isSaved) {
      return Icon(
        Icons.bookmark,
        size: 30,
      );
    } else {
      return Icon(
        Icons.bookmark_border,
        size: 30,
      );
    }
  }
}

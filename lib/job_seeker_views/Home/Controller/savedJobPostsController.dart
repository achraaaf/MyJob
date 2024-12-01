import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/JobSeekerController.dart';
import 'package:flutter_application_1/Helper/loaders.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/Repositories/authentication/authentication_Repository.dart';
import 'package:flutter_application_1/Repositories/JobPost/SavedJobPostRepository.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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

  toggleSavedJobPost(
      String userId, JobPostModel jobPost, BuildContext context) {
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
      loaders.CustomToast(message: "the post has been removed", context);
    } else {
      savedJobsRepo.saveJobPost(jobPost);
      // update the rx jobseeker data
      savedJobPosts.add(jobPost);

      // show a toast
      loaders.CustomToast(message: "the post has been saved", context);
    }
  }

  Widget getIconForSavedJobs(JobPostModel jobPost) {
    bool isSaved =
        savedJobPosts.any((post) => post.jobLocation == jobPost.jobLocation);

    if (isSaved) {
      return Icon(
        Icons.bookmark,
        color: Color(0xff181F32),
        size: 30,
      );
    } else {
      return Icon(
        Icons.bookmark_border,
        color: Color(0xff181F32),
        size: 30,
      );
    }
  }
}

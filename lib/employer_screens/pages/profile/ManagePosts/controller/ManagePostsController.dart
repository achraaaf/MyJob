import 'package:MyJob/Helper/Data.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/JobPost/JobPostsRepository.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/view/ManagePostsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagePostsController extends GetxController {
  static ManagePostsController get instance => Get.find();

  // variables
  final JobPostRepo = Get.put(JobPostsRepository());
  RxBool isLoading = false.obs;
  RxBool isLoadingEditing = false.obs;
  RxList<JobPostModel> jobPosts = <JobPostModel>[].obs;
  final jobPostRepo = JobPostsRepository.instance;

  // for editing job post
  TextEditingController JobtitleController = TextEditingController();
  TextEditingController JobDescriptionController = TextEditingController();
  TextEditingController JobLocationController = TextEditingController();
  RxString JobSalaryController = "".obs;
  RxList selectedJobTypes = [].obs;
  RxString JobCategoryController = "".obs;
  RxList RequiredSkills = [].obs;
  TextEditingController JobRequirementController = TextEditingController();
  RxList photos = [].obs;

  Rx<List<String>> filtredSkills = Rx<List<String>>([]);

  final List<String> jobTypes = [
    'Full-time',
    'Part-time',
    'Internship',
    'Temporary',
    'Freelance'
  ];

  // functions
  @override
  void onInit() {
    fetchJobposts();
    filtredSkills.value = Data.skills;

    super.onInit();
  }

  void fetchJobposts() async {
    try {
      isLoading.value = true;
      var IdsList;
      IdsList = await JobPostRepo.GetJobPostsIds();

      for (var id in IdsList) {
        var jobPost = await JobPostRepo.GetJobPostById(id);
        jobPosts.add(jobPost);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void editJobPost(String JobPostId) async {
    try {
      isLoadingEditing.value = true;
      await jobPostRepo.EditJobPost(
        JobPostId,
        {
          'jobTitle': JobtitleController.text,
          'jobDescription': JobDescriptionController.text,
          'jobLocation': JobLocationController.text,
          'jobSalary': JobSalaryController.value,
          'jobType': selectedJobTypes.value,
          'JobCategory': JobCategoryController.value,
          'RequiredSkills': RequiredSkills.value,
          'Requirement': JobRequirementController.text,
          'Photos': photos.value,
        },
      );

      final index = jobPosts.indexWhere((post) => post.id == JobPostId);
      if (index != -1) {
        jobPosts[index].jobTitle = JobtitleController.text;
        jobPosts[index].jobDescription = JobDescriptionController.text;
        jobPosts[index].jobLocation = JobLocationController.text;
        jobPosts[index].jobSalary = JobSalaryController.value;
        jobPosts[index].jobType = selectedJobTypes.value;
        jobPosts[index].JobCategory = JobCategoryController.value;
        jobPosts[index].RequiredSkills = RequiredSkills.value;
        jobPosts[index].Requirement = JobRequirementController.text;
        jobPosts[index].Photos = photos.value;
      }
      Get.off(() => ManagePostsView());
    } finally {
      isLoadingEditing.value = false;
    }
  }

  void deleteJobPost(String JobPostId) async {
    await jobPostRepo.DeleteJobPost(JobPostId);
    final index = jobPosts.indexWhere((post) => post.id == JobPostId);
    if (index != -1) {
      jobPosts.removeAt(index);
    }
    
  }

  void filtreSkillsList(String name) {
    List<String> result = [];

    if (name.isEmpty) {
      result = Data.skills;
    } else {
      result = Data.skills
          .where(
              (element) => element.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    filtredSkills.value = result;
  }

  void toggleSkill(String skill) {
    if (RequiredSkills.contains(skill)) {
      RequiredSkills.remove(skill);
    } else {
      RequiredSkills.add(skill);
    }
  }

  void addSkill(String skill) {
    if (!RequiredSkills.contains(skill)) {
      RequiredSkills.add(skill);
    }
  }

  void removeSkill(String skill) {
    if (RequiredSkills.contains(skill)) {
      RequiredSkills.remove(skill);
    }
  }

  Widget getIconForSkill(String skill) {
    if (RequiredSkills.contains(skill)) {
      return Icon(Icons.check);
    } else {
      return SizedBox.shrink();
    }
  }
}

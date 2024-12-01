// ignore_for_file: invalid_use_of_protected_member

import 'package:MyJob/Helper/Data.dart';
import 'package:MyJob/Helper/loaders.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/JobPost/JobPostsRepository.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/controller/ManagePostsController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostController extends GetxController {
  static AddPostController get instance => Get.find();

  //variables
  final jobPostRepo = Get.put(JobPostsRepository());
  final employerData = EmployerController.instance;
  // for editing job post
  TextEditingController JobtitleController = TextEditingController();
  TextEditingController JobDescriptionController = TextEditingController();
  final JobLocationController = Rxn<String>();
  RxString JobSalaryController = "10000".obs;
  RxList selectedJobTypes = [].obs;
  final JobCategoryController = Rxn<String>();
  RxList RequiredSkills = [].obs;
  TextEditingController JobRequirementController = TextEditingController();
  RxList photos = [].obs;

  RxBool isLoading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<List<String>> filtredSkills = Rx<List<String>>([]);

  final List<String> jobTypes = [
    'Full-time',
    'Part-time',
    'Internship',
    'Temporary',
    'Freelance'
  ];
  // add new job post
  void addJobPost() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    // check if everything is not empty
    if (JobLocationController.value == null) {
      loaders.CustomToast(message: "Please select location");
      return;
    }
    if (selectedJobTypes.length == 0) {
      loaders.CustomToast(message: "Please select at least one Job Type");
      return;
    }
    if (JobSalaryController.value == "0") {
      loaders.CustomToast(
          message: "please the salary must be greater than 0\$");
      return;
    }
    if (RequiredSkills.length == 0) {
      loaders.CustomToast(message: "Please select at least one Skill");
      return;
    }
    if (JobCategoryController.value == null) {
      loaders.CustomToast(message: "Please select Job Category");
      return;
    }

    try {
      isLoading.value = true;
      final JobPostModel jobPost = JobPostModel(
        id: '',
        jobTitle: JobtitleController.text,
        jobDescription: JobDescriptionController.text,
        jobLocation: JobLocationController.value.toString(),
        jobSalary: JobSalaryController.value.toString(),
        JobCategory: JobCategoryController.value.toString(),
        RequiredSkills: RequiredSkills.value,
        Requirement: JobRequirementController.text,
        Photos: photos.value,
        jobType: selectedJobTypes.value,
        PostedDate: Timestamp.now(),
        employerId: employerData.employer.value.EmployerId,
        employerName: employerData.employer.value.companyName,
        EmployerImage: employerData.employer.value.CompanyLogo,
        isPopular: false,
      );
      final newJobPost = await jobPostRepo.AddJobPost(jobPost);

      final AllPostsController = Get.put(ManagePostsController());
      AllPostsController.jobPosts.add(newJobPost);

      await Future.delayed(Duration(seconds: 3));
      Get.snackbar("Success", "Job Post added successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } finally {
      JobtitleController.clear();
      JobDescriptionController.clear();
      JobLocationController.value = null;
      JobSalaryController.value = "10000";
      JobCategoryController.value = null;
      RequiredSkills.value = [];
      JobRequirementController.clear();
      photos.value = [];
      selectedJobTypes.value = [];
      
      isLoading.value = false;

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

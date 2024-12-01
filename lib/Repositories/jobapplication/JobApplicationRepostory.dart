import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/Models/Job_seeker/jobApplication/JobApplication.dart';
import 'package:get/get.dart';

class JobApplicationRepostory extends GetxController {
  static JobApplicationRepostory get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;

  // Apply by CV/Resume
  Future<bool> ApplyByCV(
      String JobSeekerId,
      String jobPostId,
      String name,
      String email,
      String cv,
      String motivationLetter,
      BuildContext context) async {
    final snapshot = await _db
        .collection("applicationJobs")
        .where('JobSeekerId', isEqualTo: JobSeekerId)
        .where('jobPostId', isEqualTo: jobPostId)
        .get();

    if (snapshot.size > 0) {
      Get.snackbar("Error", "You have already applied for this Job!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else {
      await _db.collection("applicationJobs").add({
        "jobPostId": jobPostId,
        "JobSeekerId": JobSeekerId,
        "applicationDate": DateTime.now().toString(),
        "name": name,
        "email": email,
        "cv/resume": cv,
        "motivationLetter": motivationLetter,
        "status": "Pending"
      });
      Get.snackbar("Success", "Application submitted successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    }
  }

  Future<List<JobApplication>> fetchJobAplications(String JobSeekerId) async {
    final snapshot = await _db
        .collection("applicationJobs")
        .where('JobSeekerId', isEqualTo: JobSeekerId)
        .get();

 
    final JobApplicationsList =
        snapshot.docs.map((e) => JobApplication.fromSnapshot(e)).toList();

    return JobApplicationsList;
  }
}

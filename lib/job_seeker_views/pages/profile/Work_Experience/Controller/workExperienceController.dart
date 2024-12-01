import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/Models/Job_seeker/workExperience.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:get/get.dart';

class workExperienceController extends GetxController {
  static workExperienceController get instance => Get.find();

  //variables
  TextEditingController JobTitle = TextEditingController();
  TextEditingController Company = TextEditingController();
  TextEditingController StartDate = TextEditingController();
  TextEditingController EndDate = TextEditingController();
  TextEditingController Description = TextEditingController();

  final authRepo = AuthenticationRepository.instance;
  final JobseekerController = JobSeekerController.instance;

  addWorkExperience(BuildContext context, Map<String, dynamic> data,
      GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final db = await FirebaseFirestore.instance;

    await db
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("workExperiences")
        .add(data);

    // update the Rx job seeker values
    JobseekerController.jobSeeker.value.workExperiences
        .add(workExperience.fromJson(data));

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavigationBarJobseeker(wantedPage: 4)),
    );
  }

  updateWorkExperience(BuildContext context, String ExactJobTitle,
      workExperience WorkEperience) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("workExperiences")
        .where('title', isEqualTo: ExactJobTitle)
        .get();

    var documentID = querySnapshot.docs.first.id;

    await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("workExperiences")
        .doc(documentID)
        .update(WorkEperience.toJson());
    // update the jobseeker data
    JobseekerController.fetchJobSeekersRecord();
  }

  deleteWorkExperience(BuildContext context, String ExactJobTitle) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("workExperiences")
        .where('title', isEqualTo: ExactJobTitle)
        .get();

    var documentID = querySnapshot.docs.first.id;

    await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("workExperiences")
        .doc(documentID)
        .delete();

    // update the jobseeker data
    JobseekerController.fetchJobSeekersRecord();
  }
}

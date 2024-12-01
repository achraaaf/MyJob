import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/Models/Job_seeker/education.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:get/get.dart';

class EducationController extends GetxController {
  static EducationController get instance => Get.find();

  TextEditingController levelOfEducationController = TextEditingController();
  TextEditingController InstitutionNameController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final authRepo = Get.put(AuthenticationRepository());
  final JobseekerController = JobSeekerController.instance;

  addEducation(Map<String, dynamic> data, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("educations")
        .add(data);

    // update the jobseeker data
    JobseekerController.fetchJobSeekersRecord();
  }

  updateEducation(String exactEducation, education Education) async {

    var querySnapshot = await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("educations")
        .where("LevelofEducation", isEqualTo: exactEducation)
        .get();

    var documentId = querySnapshot.docs.first.id;

    await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("educations")
        .doc(documentId)
        .update(Education.toJson());

    // update the jobseeker data
    JobseekerController.fetchJobSeekersRecord();

  }

  void deleteEducation( String exactEducation) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("educations")
        .where('LevelofEducation', isEqualTo: exactEducation)
        .get();

    var documentID = querySnapshot.docs.first.id;
    await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("educations")
        .doc(documentID)
        .delete();

    // update the jobseeker data
    JobseekerController.fetchJobSeekersRecord();

    
  }
}

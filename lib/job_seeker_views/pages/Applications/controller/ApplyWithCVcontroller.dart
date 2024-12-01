import 'dart:io';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/jobapplication/JobApplicationRepostory.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/Applications/controller/JobApplicationsController.dart';
import 'package:get/get.dart';

class ApplyWithCVcontroller extends GetxController {
  static ApplyWithCVcontroller instance = Get.find();

  final Jobseeker = JobSeekerController.instance;
  final applyRepo = Get.put(JobApplicationRepostory());

  final jobAppRepo = Get.put(JobApplicationsController());
  final currentUserId = AuthenticationRepository.instance.authUser!.uid;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController motivationLetterController = TextEditingController();
  Rxn<File> cvFile = Rxn<File>();
  String? cvFileName;
  String? cvFileExtension;
  String? cvFileSize;
  String? cvFilePath;
  String? cvUrl;

  final db = FirebaseFirestore.instance;

  final isLoading = false.obs;

  Future uploadCV() async {
    final pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      final platformFile = pickedFile.files.first;
      final file = File(platformFile.path!);
      cvFile.value = file;
      cvFileName = platformFile.name;
      cvFileExtension = platformFile.extension;
      cvFileSize = _formatFileSize(file.lengthSync());
      cvFilePath = platformFile.path;
    }
  }

  void removeCV() {
    cvFile.value = null;
    cvFileName = null;
    cvFileExtension = null;
    cvFileSize = null;
    cvFilePath = null;
    update();
  }

  bool get hasCV => cvFile.value != null;

  String _formatFileSize(int bytes) {
    const int KB = 1024;
    const int MB = 1024 * KB;

    if (bytes >= MB) {
      return '${(bytes / MB).toStringAsFixed(2)} MB';
    } else if (bytes >= KB) {
      return '${(bytes / KB).toStringAsFixed(2)} KB';
    } else {
      return '$bytes bytes';
    }
  }

  submit(JobPostModel jobPost, BuildContext context,
      GlobalKey<FormState> applyWithCVFormKey) async {
    if (!applyWithCVFormKey.currentState!.validate()) {
      return;
    }

    if (cvFile.value == null) {
      Get.snackbar("Error", "Please select a CV/Resume file to apply.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    // Access the selected CV file
    final cv = cvFile.value!;

    try {
      isLoading.value = true;

      final storage = FirebaseStorage.instance;
      final cvRef = storage.ref().child('cvs/${cv.path.split('/').last}');
      await cvRef.putFile(cv);

      // Get the download URL for the uploaded CV
      cvUrl = await cvRef.getDownloadURL();

      final applicationId = await applyRepo.ApplyByCV(
          currentUserId,
          jobPost.id,
          nameController.text,
          emailController.text,
          cvUrl!,
          motivationLetterController.text,
          context);
      if (applicationId != "") {
        Map<String, dynamic> notificationData = {
          'title': "Application received",
          "content":
              "You've received a new application from ${Jobseeker.jobSeeker.value.name} for the ${jobPost.jobTitle} position. View their profile now!",
          "type": "new_application",
          "timestamp": Timestamp.now(),
          "sender_id": Jobseeker.jobSeeker.value.id,
          "recipient_id": jobPost.employerId,
          "application_id": applicationId
        };

        final userRef = db
            .collection("notifications")
            .doc(notificationData["recipient_id"]);
        userRef.collection("Allnotifications").add(notificationData);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      Future.delayed(Duration(seconds: 3), () {
        isLoading.value = false;
      });
    }

    cvFile.value = null;
    nameController.text = "";
    emailController.text = "";
    motivationLetterController.text = "";

    applyWithCVFormKey.currentState!.reset();

    jobAppRepo.fetchJobApplications();

    ApplyWithCVcontroller().update();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavigationBarJobseeker(wantedPage: 2)),
    );
  }

  String generateUniqueId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}

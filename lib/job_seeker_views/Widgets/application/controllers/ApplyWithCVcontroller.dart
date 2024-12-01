import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/JobSeekerController.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/Repositories/jobapplication/JobApplicationRepostory.dart';
import 'package:flutter_application_1/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:get/get.dart';

enum Validate {
  Pending,
  OK,
}

class ApplyWithCVcontroller extends GetxController {
  static ApplyWithCVcontroller instance = Get.find();

  final Jobseeker = JobSeekerController.instance;
  final applyRepo = Get.put(JobApplicationRepostory());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController motivationLetterController = TextEditingController();
  Rxn<File> cvFile = Rxn<File>();
  String? cvFileName;
  String? cvFileExtension;
  String? cvFileSize;
  String? cvFilePath;
  String? cvUrl;

  final isLoading = false.obs;

  //final applyWithCVFormKey = GlobalKey<FormState>();

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

  submit(JobPostModel jobPost, BuildContext context, GlobalKey<FormState> formkey) async {
    if (!formkey.currentState!.validate()) {
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
      final cvRef = storage.ref().child(
          'cvs/${cv.path.split('/').last}'); // Create a reference with appropriate path
      await cvRef.putFile(cv);

      // Get the download URL for the uploaded CV
      cvUrl = await cvRef.getDownloadURL();

      await applyRepo.ApplyByCV(
          Jobseeker.jobSeeker.value.id,
          jobPost.id,
          nameController.text,
          emailController.text,
          cvUrl!,
          motivationLetterController.text,
          context);
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

    formkey.currentState!.reset();

    update();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavigationBarJobseeker(wantedPage: 2)),
    );
  }
}

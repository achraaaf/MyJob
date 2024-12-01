import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/Auth_Repository/authentication_Repository.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class workExperienceController extends GetxController {
  static workExperienceController get instance => Get.find();

  //variables
  TextEditingController JobTitle = TextEditingController();
  TextEditingController Company = TextEditingController();
  TextEditingController StartDate = TextEditingController();
  TextEditingController EndDate = TextEditingController();
  TextEditingController Description = TextEditingController();
  GlobalKey<FormState> WorkExperienceFormKey = GlobalKey<FormState>();

  final authRepo = Get.put(AuthenticationRepository());

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

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavigationBarJobseeker(wantedPage: 4)),
    );
  }

  updateWorkExperience(BuildContext context, String ExactJobTitle,
      GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("workExperiences")
        .where('title', isEqualTo: ExactJobTitle)
        .get();

      var documentID = querySnapshot.docs.first.id;

      print(JobTitle.text);
      print(Company);
      print(StartDate);
      print(EndDate);
      print(Description);

      await FirebaseFirestore.instance
          .collection("Job_seekers")
          .doc(authRepo.authUser!.uid)
          .collection("workExperiences")
          .doc(documentID)
          .update({
        'title': JobTitle.text,
        'company': Company.text,
        'Start_date': StartDate.text,
        'End_date': EndDate.text,
        'description': Description.text,
      });

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: BottomNavigationBarJobseeker(wantedPage: 4)));
    }
  }
}

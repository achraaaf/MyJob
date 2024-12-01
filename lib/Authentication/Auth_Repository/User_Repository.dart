import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Authentication/Auth_Repository/authentication_Repository.dart';
import 'package:flutter_application_1/Models/Job_seeker/education.dart';
import 'package:flutter_application_1/Models/Job_seeker/workExperience.dart';
import 'package:flutter_application_1/Models/User_Model.dart';
import 'package:flutter_application_1/Models/Job_seeker/Job_seeker.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get Instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final userid = FirebaseAuth.instance.currentUser?.uid;
  final authRepo = Get.put(AuthenticationRepository());

  createUser(UserModel user) async {
    _db.collection('Users').doc(user.id).set(user.toJson());
    ;

    // storing data into the specefied User
    if (user.role == "job_seeker") {
      _db.collection("Job_seekers").doc(user.id).set({
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'phone': "",
        'city': "",
        'picture': "",
        'skills': [],
        'workExperience': [],
        'educations': [],
        'languages': [],
        'AboutMe': ''
      });
    } else if (user.role == "employer") {
      // later
    }
  }

  Future<Job_seeker> getJobSeekerData() async {
    try {
      final userId = authRepo.authUser?.uid;
      final mainDocument =
          await _db.collection("Job_seekers").doc(userId).get();

      print(userid);
      if (mainDocument.exists) {
        var data = Job_seeker.fromSnapshot(mainDocument);
        Job_seeker jobSeeker = data;
        // Fetch work Experience subcollection
        final workExperiencesSnapshot =
            await mainDocument.reference.collection('workExperiences').get();
        jobSeeker.workExperiences = workExperiencesSnapshot.docs
            .map((doc) => workExperience.fromSnapshot(doc))
            .toList();

        // Fetch educations subcollection
        final educationsSnapshot =
            await mainDocument.reference.collection('educations').get();
        jobSeeker.educations = educationsSnapshot.docs
            .map((doc) => education.fromSnapshot(doc))
            .toList();

        return jobSeeker;
      } else {
        return Job_seeker.emptyJobseeker();
      }
    } catch (e) {
      throw "something went wrong";
    }
  }

  Future<void> updateJobseekerData(Job_seeker updateUser) async {
    try {
      await _db
          .collection("Job_seekers")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } catch (e) {
      throw "something went wrong";
    }
  }
}

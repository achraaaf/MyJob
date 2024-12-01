import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/Models/Job_seeker/education.dart';
import 'package:MyJob/Models/Job_seeker/workExperience.dart';
import 'package:MyJob/Models/User_Model.dart';
import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get Instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final authRepo = AuthenticationRepository.instance;

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
        'city': "New York, USA",
        'picture': "",
        'skills': [],
        'workExperience': [],
        'educations': [],
        'languages': [],
        'AboutMe': '',
      });
    } else if (user.role == "employer") {
      _db.collection("employers").doc(user.id).set({
        'id': user.id,
        'email': user.email,
        'companyName': user.name,
        'phone': "",
        'city': "New York, USA",
        'companyLogo':
            "https://firebasestorage.googleapis.com/v0/b/myproject-9acf3.appspot.com/o/User%2FImages%2FProfile%2Fscaled_4812244.png?alt=media&token=215171ac-95ea-4d86-8183-4269e102d463",
        'description': "",
        'industry': "Technology IT",
        'website': "",
        'companySize': "1 - 10 Employees",
      });
    }
  }

  Future<Job_seeker> getJobSeekerData() async {
    try {
      final userId = authRepo.authUser!.uid;

      final mainDocument =
          await _db.collection("Job_seekers").doc(userId).get();

      //print(userid);
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

  Future<Employer> getEmployerData() async {
    try {
      final userId = authRepo.authUser!.uid;

      final mainDocument = await _db.collection("employers").doc(userId).get();

      //print(userid);
      if (mainDocument.exists) {
        var data = Employer.fromSnapshot(mainDocument);

        Employer employer = data;
        return employer;
      } else {
        return Employer.emptyEmployer();
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

  Future<void> updatesinglefield(
      String Collection, Map<String, dynamic> field) async {
    try {
      await _db
          .collection(Collection)
          .doc(authRepo.authUser!.uid)
          .update(field);
    } catch (e) {
      throw "something went wrong";
    }
  }

  Future<void> updateOnUserCollection(Map<String, dynamic> field) async {
    try {
      //await _db.collection("Users").doc(authRepo.authUser!.uid).update(field);
    } catch (e) {
      throw "something went wrong";
    }
  }

  // get The user type
  Future<String> getUserType(String uid) async {
    final userDocument = await _db.collection('Users').doc(uid).get();

    return userDocument.data()!['role'].toString();
  }

  // upload profile picture
  Future<String> uploadimage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      return url;
    } catch (e) {
      throw "something went wrong";
    }
  }

  Future<Employer> getEmployerDataById(String ID) async {
    final employerDocument = await _db.collection("employers").doc(ID).get();
    final employer = Employer.fromSnapshot(employerDocument);
    return employer;
  }

  Future<Job_seeker> getJobSeekerDataById(String ID) async {
    final JobSeekerDocument = await _db.collection("Job_seekers").doc(ID).get();
    final jobSeeker = Job_seeker.fromSnapshot(JobSeekerDocument);
    final workExperiencesSnapshot =
        await JobSeekerDocument.reference.collection("workExperiences").get();
    final educationsSnapshot =
        await JobSeekerDocument.reference.collection("educations").get();
    workExperiencesSnapshot.docs.forEach((doc) {
      jobSeeker.workExperiences.add(workExperience.fromSnapshot(doc));
    });
    
    educationsSnapshot.docs.forEach((doc) {
      jobSeeker.educations.add(education.fromSnapshot(doc));
    });
    return jobSeeker;
  }

  Future<List<Job_seeker>> getJobSeekersList() async {
    final JobSeekersDocument = await _db.collection("Job_seekers").get();
    final List<Job_seeker> jobSeekers = [];

    JobSeekersDocument.docs.forEach((doc) {
      final jobSeeker = Job_seeker.fromSnapshot(doc);
      doc.reference.collection('workExperiences').get().then((value) {
        jobSeeker.workExperiences =
            value.docs.map((doc) => workExperience.fromSnapshot(doc)).toList();
      });
      doc.reference.collection('educations').get().then((value) {
        jobSeeker.educations =
            value.docs.map((doc) => education.fromSnapshot(doc)).toList();
      });

      jobSeekers.add(jobSeeker);
    });

    return jobSeekers;
  }
}

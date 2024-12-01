import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/education/addEducation.dart';

class FirebaseService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getJobPostsStream() {
    return FirebaseFirestore.instance.collection('job_posts').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSavedJobsStream(
      String jobSeekerId) {
    return FirebaseFirestore.instance
        .collection('Job_seekers')
        .doc(jobSeekerId)
        .collection('saved_jobs')
        .snapshots();
  }

  static Future<void> saveJobPost(String jobpostId, String jobSeekerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Job_seekers')
          .doc(jobSeekerId)
          .collection('saved_jobs')
          .doc(jobpostId)
          .set({'postId': jobpostId});
    } catch (e) {
      // Handle errors
      print('Error saving job post: $e');
    }
  }

  // =========== get the data from job_posts by the id ===============
  static Future<Map<String, dynamic>?> getJobPostData(String jobPostId) async {
    try {
      DocumentSnapshot jobPostSnapshot = await FirebaseFirestore.instance
          .collection('job_posts')
          .doc(jobPostId)
          .get();

      // Check if the document exists
      if (jobPostSnapshot.exists) {
        // Return the data of the job post
        return jobPostSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting job post data: $e');
      return null;
    }
  }

 

  // =====================( get the skills from firestore )====================
  static Future<List<String>?> getSkills(String jobSeekerId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("Job_seekers")
          .doc(jobSeekerId)
          .get();

      if (userSnapshot.exists) {
        List<String> skills = List<String>.from(userSnapshot['skills'] ?? []);

        return skills;
      }

      return null;
    } catch (e) {
      print('Error getting skills: $e');
      return null;
    }
  }


  // =====================( get the languages from firestore )====================
  static Future<List<String>?> getLanguages(String jobSeekerId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("Job_seekers")
          .doc(jobSeekerId)
          .get();

      if (userSnapshot.exists) {
        List<String> languages =
            List<String>.from(userSnapshot['languages'] ?? []);

        return languages;
      }

      return null;
    } catch (e) {
      print('Error getting skills: $e');
      return null;
    }
  }

  static Future<void> addWorkExperience(
      String jobSeekerId, Map<String, dynamic> workExperienceData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Job_seekers')
          .doc(jobSeekerId)
          .collection("workExperiences")
          .add(workExperienceData);
    } catch (e) {
      print("Error adding work experience: $e");
      throw e;
    }
  }

  static Future<void> addEducation(
      String jobSeekerId, Map<String, dynamic> educationData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Job_seekers')
          .doc(jobSeekerId)
          .collection("educations")
          .add(educationData);
    } catch (e) {
      print("Error adding education: $e");
      throw e;
    }
  }
}

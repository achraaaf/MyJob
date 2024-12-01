import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobPostsRepository extends GetxController {
  static JobPostsRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;
  final currentUser = AuthenticationRepository.instance.authUser!.uid;

  // fetch job posts
  Future<List<JobPostModel>> GetJobPosts() async {
    final snapshot =
        await db.collection('job_posts').orderBy('PostedDate').get();
    final Lists =
        snapshot.docs.map((doc) => JobPostModel.fromSnapshot(doc)).toList();
    return Lists;
  }

  Future<JobPostModel> GetJobPostById(String JobPostId) async {
    final snapshot = await db.collection('job_posts').doc(JobPostId).get();

    return JobPostModel.fromSnapshot(snapshot);
  }

  Future<List<String>> GetJobPostsIds() async {
    final mainDuc = await db.collection("employers").doc(currentUser).get();

    final snapshot = await mainDuc.reference.collection("JobPosts").get();

    final IdsLists = snapshot.docs.map((doc) => doc.id).toList();
    return IdsLists;
  }

  Future<Map<String, int>> GetApplicationsData(String UserId) async {
    var openJobs = 0;
    var pendingJobs = 0;
    var rejected = 0;
    var totalapplicant = 0;
    var hired = 0;
    final mainDuc = await db
        .collection("employers")
        .doc(UserId)
        .collection('JobPosts')
        .get();

    openJobs = mainDuc.docs.length;

    final PostsIds = await GetJobPostsIds();

    final applicationsSnapshot = await db
        .collection("applicationJobs")
        .where("jobPostId", whereIn: PostsIds)
        .get();

    applicationsSnapshot.docs.forEach((doc) {
      if (doc.data()['status'] == "Pending") {
        pendingJobs++;
      } else if (doc.data()['status'] == "Rejected") {
        rejected++;
      } else if (doc.data()['status'] == "Approved") {
        hired++;
      }
    });

    totalapplicant = applicationsSnapshot.docs.length;

    Map<String, int> Data = {
      "openJobs": openJobs,
      "pendingJobs": pendingJobs,
      "rejected": rejected,
      "totalapplicant": totalapplicant,
      "hired": hired,
    };

    return Data;
  }

  // add job post
  Future<JobPostModel> AddJobPost(JobPostModel jobPost) async {
    final JobPostDoc = await db.collection("job_posts").add(jobPost.toJson());
    await db.collection("job_posts").doc(JobPostDoc.id).update({
      "id": JobPostDoc.id,
    });

    await db
        .collection("employers")
        .doc(currentUser)
        .collection("JobPosts")
        .doc(JobPostDoc.id)
        .set({
      "PostId": JobPostDoc.id,
    });

    final Document = await db.collection("job_posts").doc(JobPostDoc.id).get();

    final JobPost = JobPostModel.fromSnapshot(Document);

    return JobPost;
  }

  Future<void> EditJobPost(
      String JobPostId, Map<String, dynamic> fields) async {
    try {
      await db.collection("job_posts").doc(JobPostId).update(fields);
      Get.snackbar("Success", "Job Post edited successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong, Please try again",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> DeleteJobPost(String JobPostId) async {
    try {
      await db.collection("job_posts").doc(JobPostId).delete();
      await db
          .collection("employers")
          .doc(currentUser)
          .collection("JobPosts")
          .doc(JobPostId)
          .delete();

      Get.snackbar("Success", "Job Post deleted successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong, Please try again",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

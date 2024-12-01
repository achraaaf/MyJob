import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:get/get.dart';

class JobPostsRepository extends GetxController {
  static JobPostsRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  // fetch job posts
  Future<List<JobPostModel>> GetJobPosts() async {
    final snapshot = await db.collection('job_posts').get();
    final Lists =
        snapshot.docs.map((doc) => JobPostModel.fromSnapshot(doc)).toList();
    return Lists;
  }
}

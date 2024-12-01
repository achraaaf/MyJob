import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:get/get.dart';

class savedJobPostRepository extends GetxController {
  static savedJobPostRepository get Instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final authRepo = AuthenticationRepository.instance;

  Future<List<JobPostModel>> GetSavedJobPosts() async {
    final userRef = _db.collection('Job_seekers').doc(authRepo.authUser!.uid);
    final querySnapshot = await userRef.collection('savedJobs').get();
    List<JobPostModel> savedJobPosts = [];
    querySnapshot.docs.forEach((doc) {
      savedJobPosts.add(JobPostModel.fromSnapshot(doc));
    });

    return savedJobPosts;
  }

  Future saveJobPost(JobPostModel jobPost) async {
    await _db
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("savedJobs")
        .doc(jobPost.id)
        .set(jobPost.toJson());
  }

  Future removeJobPost(JobPostModel jobPost) async {
    await _db
        .collection("Job_seekers")
        .doc(authRepo.authUser!.uid)
        .collection("savedJobs")
        .doc(jobPost.id)
        .delete();
  }
}

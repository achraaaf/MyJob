import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:get_storage/get_storage.dart';

class savedJobPostRepository {
  static final _storage = GetStorage();

  static void saveJobPost(String userId, JobPostModel jobPost) {
    final userKey = 'user_$userId';
    List<dynamic>? savedPosts = _storage.read(userKey) ?? [];
    savedPosts.add(jobPost.toJson());

    _storage.write(userKey, savedPosts);
  }

  static void removeJobPost(String userId, JobPostModel jobPost) {
    final userKey = 'user_$userId';

    List<dynamic>? savedPosts = _storage.read(userKey);
    if (savedPosts != null) {
      savedPosts.removeWhere((json) =>
          JobPostModel.fromJson(json).jobLocation == jobPost.jobLocation);
      _storage.write(userKey, savedPosts);
    }
  }

  static List<JobPostModel> getSavedJobPosts(String userId) {
    final userKey = 'user_$userId';
    List<dynamic>? savedPosts = _storage.read(userKey);
    if (savedPosts != null) {
      return savedPosts.map((json) => JobPostModel.fromJson(json)).toList();
    }
    return [];
  }

  static void clearSavedJobPosts(String userId) {
    final userKey = 'user_$userId';
    _storage.remove(userKey);
  }
}

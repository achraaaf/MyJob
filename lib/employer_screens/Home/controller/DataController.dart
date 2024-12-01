import 'package:MyJob/Repositories/JobPost/JobPostsRepository.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();

  //variables
  RxBool isNewNoti = false.obs;
  final CollectionReference _notificationsRef = FirebaseFirestore.instance
      .collection('notifications')
      .doc(AuthenticationRepository.instance.authUser!.uid)
      .collection("Allnotifications");

  final currentuser = AuthenticationRepository.instance.authUser!.uid;
  final jobPostsRepo = Get.put(JobPostsRepository());
  RxInt openJobs = 0.obs;
  RxInt pendingJobs = 0.obs;
  RxInt Rejected = 0.obs;
  RxInt Totalapplicant = 0.obs;
  RxInt Hired = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    FetchData();
    _listenForNewNotification();
  }

  void FetchData() async {
    final Map<String, int> Data =
        await jobPostsRepo.GetApplicationsData(currentuser);
    openJobs.value = Data['openJobs']!;
    pendingJobs.value = Data['pendingJobs']!;
    Rejected.value = Data['rejected']!;
    Totalapplicant.value = Data['totalapplicant']!;
    Hired.value = Data['hired']!;
  }


  void _listenForNewNotification() {
    _notificationsRef
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        final Timestamp timestamp = data['timestamp'];
        final DateTime notificationTime = timestamp.toDate();
        final DateTime now = DateTime.now();

        final difference = now.difference(notificationTime);
        if (difference.inMinutes <= 15) {
          isNewNoti.value = true;
        } else {
          isNewNoti.value = false;
        }
      } else {
        isNewNoti.value = false;
      }
    });
  }
}

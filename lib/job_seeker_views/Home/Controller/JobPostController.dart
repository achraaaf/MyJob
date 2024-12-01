import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/JobPost/JobPostsRepository.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JobPostController extends GetxController {
  static JobPostController get instance => Get.find();
  final JobPostRepo = Get.put(JobPostsRepository());

  RxList<JobPostModel> jobPostsList = <JobPostModel>[].obs;
  RxList<JobPostModel> filteredJobPostsList = <JobPostModel>[].obs;
  RxList<JobPostModel> PopularJobPosts = <JobPostModel>[].obs;

  RxBool isNewNoti = false.obs;

  RxBool isLoading = false.obs;
  final CollectionReference _notificationsRef = FirebaseFirestore.instance
      .collection('notifications')
      .doc(AuthenticationRepository.instance.authUser!.uid)
      .collection("Allnotifications");

  // Variables for filtering
  final RxString lastUpdate = ('anytime').obs;
  final RxString selectedCategory = ('All').obs;
  final selectedJobTypes = RxList<String>([]);
  final RxString selectedLocation = ('All').obs;
  final minSalary = RxInt(10000);
  final maxSalary = RxInt(30000);

  final List<String> jobTypes = [
    'Full-time',
    'Part-time',
    'Internship',
    'Temporary',
    'Freelance'
  ];

  @override
  void onInit() {
    fetchJobPosts();
    _listenForNewNotification();
    super.onInit();
  }

  void fetchJobPosts() async {
    try {
      isLoading.value = true;
      final JobPosts = await JobPostRepo.GetJobPosts();

      jobPostsList.assignAll(JobPosts);
      PopularJobPosts.value =
          jobPostsList.where((jobPost) => jobPost.isPopular).toList();
    } finally {
      isLoading.value = false;
    }
  }

  // filter the job posts based on the search query
  void searchJobPosts(String query) {
    if (query.isEmpty) {
      filteredJobPostsList.value = jobPostsList.toList();
    }

    final lowerCaseQuery = query.toLowerCase();

    filteredJobPostsList.value = jobPostsList
        .where((jobPost) =>
            jobPost.jobTitle.toLowerCase().startsWith(lowerCaseQuery))
        .toList();

    // ignore: invalid_use_of_protected_member
    filteredJobPostsList.value.addAll(jobPostsList
        .where((jobPost) =>
            jobPost.jobTitle.toLowerCase().contains(lowerCaseQuery) &&
            !jobPost.jobTitle.toLowerCase().startsWith(lowerCaseQuery))
        .toList());
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

  final List<String> cities = [
    'All',
    // Morocco
    'Casablanca, Morocco',
    'Rabat, Morocco',
    'Marrakech, Morocco',
    'Tanger, Morocco',
    'Meknes, Morocco',
    'Fes, Morocco',
    'Agadir, Morocco',
    'Essaouira, Morocco',
    'Chefchaouen, Morocco',
    'Ouarzazate, Morocco',
    'Tetouan, Morocco',
    'El Jadida, Morocco', 'Kenitra, Morocco',
    'Safi, Morocco',
    'Mohammedia, Morocco',
    'Khouribga, Morocco',
    'Nador, Morocco',
    'Settat, Morocco',
    'Al Hoceima, Morocco',
    'Larache, Morocco',
    // United States
    'New York, USA',
    'Los Angeles, USA',
    'Chicago, USA',
    'Houston, USA',
    'Philadelphia, USA',
    'Phoenix, USA',
    'San Antonio, USA',
    'San Diego, USA',
    'Dallas, USA',
    'San Jose, USA',
    'Austin, USA',
    'Jacksonville, USA',
    'San Francisco, USA',
    'Indianapolis, USA',
    'Columbus, USA',
    'Fort Worth, USA',
    'Charlotte, USA',
    'Seattle, USA',
    'Denver, USA',
    'Washington, USA',

    // Canada
    'Toronto, Canada',
    'Montreal, Canada',
    'Vancouver, Canada',
    'Calgary, Canada',
    'Edmonton, Canada',
    'Ottawa, Canada',
    'Quebec City, Canada',
    'Winnipeg, Canada',
    'Hamilton, Canada',
    'London, Canada',

    // United Kingdom
    'London, United Kingdom',
    'Birmingham, United Kingdom',
    'Manchester, United Kingdom',
    'Glasgow, United Kingdom',
    'Liverpool, United Kingdom',
    'Leeds, United Kingdom',
    'Sheffield, United Kingdom',
    'Edinburgh, United Kingdom',
    'Bristol, United Kingdom',
    'Cardiff, United Kingdom',

    // Australia
    'Sydney, Australia',
    'Melbourne, Australia',
    'Brisbane, Australia',
    'Perth, Australia',
    'Adelaide, Australia',
    'Gold Coast, Australia',
    'Newcastle, Australia',
    'Canberra, Australia',
    'Sunshine Coast, Australia',
    'Wollongong, Australia',

    // France
    'Paris, France',
    'Marseille, France',
    'Lyon, France',
    'Toulouse, France',
    'Nice, France',
    'Nantes, France',
    'Strasbourg, France',
    'Montpellier, France',
    'Bordeaux, France',
    'Lille, France',

    // Germany
    'Berlin, Germany',
    'Hamburg, Germany',
    'Munich, Germany',
    'Cologne, Germany',
    'Frankfurt, Germany',
    'Stuttgart, Germany',
    'Düsseldorf, Germany',
    'Dortmund, Germany',
    'Essen, Germany',
    'Leipzig, Germany',

    // Spain
    'Barcelona, Spain',
    'Madrid, Spain',
    'Valencia, Spain',
    'Seville, Spain',
    'Zaragoza, Spain',
    'Málaga, Spain',
    'Murcia, Spain',
    'Palma de Mallorca, Spain',
    'Las Palmas de Gran Canaria, Spain',
    'Bilbao, Spain',
  ];

  void filterJobPosts() {
    filteredJobPostsList.assignAll(jobPostsList.where((jobPost) {
      bool match = true;

      if (lastUpdate.value != 'anytime') {
        DateTime currentDate = DateTime.now();

        Map<String, Duration> updateDurations = {
          'recent': Duration(days: 1),
          'last_week': Duration(days: 7),
          'last_month': Duration(days: 30),
        };

        // Get the duration based on the selected last update option
        Duration duration = updateDurations[lastUpdate.value]!;

        DateTime postDate = jobPost.PostedDate.toDate();

        // Calculate the difference between current date and post date
        Duration difference = currentDate.difference(postDate);

        // Set match to false if the difference is greater than the selected duration
        match = difference <= duration;
      }

      if (selectedCategory.value != 'All') {
        match = match && jobPost.JobCategory == selectedCategory.value;
      }
      if (selectedJobTypes.isNotEmpty) {
        match = match &&
            selectedJobTypes.any((type) => jobPost.jobType.contains(type));
      }
      if (selectedLocation.value != 'All') {
        match = match && jobPost.jobLocation == selectedLocation.value;
      }
      if (minSalary.value != 0 || maxSalary.value != 50000) {
        final jobSalary = double.tryParse(
            jobPost.jobSalary.replaceAll(RegExp(r'[^\d.]'), ''));
        match = match &&
            jobSalary != null &&
            jobSalary >= minSalary.value &&
            jobSalary <= maxSalary.value;
      }

      return match;
    }).toList());
  }
}
